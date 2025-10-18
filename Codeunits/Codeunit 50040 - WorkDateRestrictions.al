codeunit 50040 WorkDateRestrictions
{
    SingleInstance = true;

    trigger OnRun()
    begin
        Timer := Timer.Timer(); // create a Timer instance
        IF ISNULL(Timer) THEN BEGIN
          Timer := Timer.Timer;
          Timer.RedirectExceptions := TRUE;
          Timer.Interval := 10000; // 10 seconds
          Timer.Start();
        END;
    end;

    var
       // [WithEvents]
        Timer: DotNet Timer;
        recUserSetup: Record 91;

    trigger Timer::Elapsed(sender: Variant;e: DotNet EventArgs)
    begin
        IF TODAY <> WORKDATE THEN BEGIN
          IF NOT recUserSetup."User May Change WORKDATE" THEN BEGIN
            WORKDATE := TODAY;
            MESSAGE('You may not change the WORKDATE. WORKDATE has been resetted');
          END;
        END;
    end;

    // trigger Timer::ExceptionOccurred(sender: Variant;e: DotNet ExceptionOccurredEventArgs)
    // begin
    // end;
}

