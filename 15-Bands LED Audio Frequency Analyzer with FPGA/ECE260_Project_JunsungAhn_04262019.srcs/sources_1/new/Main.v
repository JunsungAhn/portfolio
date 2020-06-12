`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digipen Institute of Technology
// Engineer: Junsung Ahn
// 
// Create Date: 04/26/2019
// Design Name: ECE260 Frq Analyzer
// Module Name: Main
// Project Name: ECE260 Frq Analyzer
// Target Devices: Nexys4 DDR
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// CLK generator
// Generates 3.125Mhz for microphone
// Generates 32Khz for sampling
module CLK_Generator(
    input logic _SystemClock,
    output logic _MicCLK,
    output logic _SineSampleClock );
    
    //reg[4:0] ClockCounter_ = 5'b0;
    reg[6:0] ClockCounter_ = 8'b0;
    reg[10:0] SampleClockCounter_ = 0;
    
    always @ (posedge _SystemClock)
    begin
        if (SampleClockCounter_ == 1562)
        begin
            _SineSampleClock = ~_SineSampleClock;
            SampleClockCounter_ = 0;
        end
        ClockCounter_ = ClockCounter_ + 1;
        SampleClockCounter_ = SampleClockCounter_ + 1;
    end
    
    // [0] -> 100M / 2^1
    // [1] -> 100M / 2^2
    // [2] -> 100M / 2^3
    // [4] -> 3.125M Hz
    assign _MicCLK = ClockCounter_[4];
    
    // [n] -> 100M / 2^(n-1)
    // [12] -> 100M / 2^(12-1) = 48.828KHz
endmodule


// SineWave LUT
// Returns 32 phases of sinewave
// Frequency will be defined how the phase is incremented
module SampleSineWave (
    input logic _SysCLK,
    input logic [4:0] _Phase, // 0-31 phase
    output logic[7:0] _SineWaveSampleData );

    always @ (posedge _SysCLK)
    begin
        if (_Phase == 0)
        begin
            _SineWaveSampleData = 128;
        end
        
        else if (_Phase ==1)
        begin
            _SineWaveSampleData = 152;
        end
        
        else if (_Phase == 2)
        begin
            _SineWaveSampleData = 176;      
        end
        
        else if (_Phase == 3)
        begin
            _SineWaveSampleData = 198;
        end
        
        else if (_Phase == 4)
        begin
            _SineWaveSampleData = 217;
        end
        
        else if (_Phase == 5)
        begin
            _SineWaveSampleData = 233;
        end
        
        else if (_Phase == 6)
        begin
            _SineWaveSampleData = 245;
        end
        
        else if (_Phase == 7)
        begin
            _SineWaveSampleData = 252;
        end
        
        else if (_Phase == 8)
        begin
            _SineWaveSampleData = 255;
        end

        else if (_Phase == 9)
        begin
            _SineWaveSampleData = 252;
        end
        
        else if (_Phase == 10)
        begin
            _SineWaveSampleData = 245;
        end
        
        else if (_Phase == 11)
        begin
            _SineWaveSampleData = 233;
        end

        else if (_Phase == 12)
        begin
            _SineWaveSampleData = 217;
        end
        
        else if (_Phase == 13)
        begin
            _SineWaveSampleData = 198;
        end
        
        else if (_Phase == 14)
        begin
            _SineWaveSampleData = 176;
        end
        
        else if (_Phase == 15)
        begin
            _SineWaveSampleData = 152;
        end
        
        else if (_Phase == 16)
        begin
            _SineWaveSampleData = 128;
        end
        
        else if (_Phase == 17)
        begin
            _SineWaveSampleData = 103;
        end

        else if (_Phase == 18)
        begin
            _SineWaveSampleData = 79;
        end
        
        else if (_Phase == 19)
        begin
            _SineWaveSampleData = 57;
        end
        
        else if (_Phase == 20)
        begin
            _SineWaveSampleData = 38;
        end

        else if (_Phase == 21)
        begin
            _SineWaveSampleData = 22;
        end
        
        else if (_Phase == 22)
        begin
            _SineWaveSampleData = 10;
        end
        
        else if (_Phase == 23)
        begin
            _SineWaveSampleData = 3;
        end

        else if (_Phase == 24)
        begin
            _SineWaveSampleData = 1;
        end
        
        else if (_Phase == 25)
        begin
            _SineWaveSampleData = 3;
        end
        
        else if (_Phase == 26)
        begin
            _SineWaveSampleData = 10;
        end
        
        else if (_Phase == 27)
        begin
            _SineWaveSampleData = 22;
        end
        
        else if (_Phase == 28)
        begin
            _SineWaveSampleData = 38;
        end
        
        else if (_Phase == 29)
        begin
            _SineWaveSampleData = 57;
        end
        
        else if (_Phase == 30)
        begin
            _SineWaveSampleData = 79; 
        end
        
        else if (_Phase == 31)
        begin
            _SineWaveSampleData = 103;
        end
    end
    /*
    // 32step, 8bit unsigned sinewave table
    // [n] = (sine(2pi* (n/32)) * ((2^7)-1)) + 128
    assign SineWaveTable[0] = 128;
    assign SineWaveTable[1] = 152;
    assign SineWaveTable[2] = 176;
    assign SineWaveTable[3] = 198;
    assign SineWaveTable[4] = 217;
    assign SineWaveTable[5] = 233;
    assign SineWaveTable[6] = 245;
    assign SineWaveTable[7] = 252;
    assign SineWaveTable[8] = 255;
    assign SineWaveTable[9] = 252;
    assign SineWaveTable[10] = 245;
    assign SineWaveTable[11] = 233;
    assign SineWaveTable[12] = 217;
    assign SineWaveTable[13] = 198;
    assign SineWaveTable[14] = 176;
    assign SineWaveTable[15] = 152;
    assign SineWaveTable[16] = 128;
    assign SineWaveTable[17] = 103;
    assign SineWaveTable[18] = 79;
    assign SineWaveTable[19] = 57;
    assign SineWaveTable[20] = 38;
    assign SineWaveTable[21] = 22;
    assign SineWaveTable[22] = 10;
    assign SineWaveTable[23] = 3;
    assign SineWaveTable[24] = 1;
    assign SineWaveTable[25] = 3;
    assign SineWaveTable[26] = 10;
    assign SineWaveTable[27] = 22;
    assign SineWaveTable[28] = 38;
    assign SineWaveTable[29] = 57;
    assign SineWaveTable[30] = 79;
    assign SineWaveTable[31] = 103;
    */
    
endmodule


// Record the sound from the outside
module Microphone#(parameter M = 1) (
    input logic _MicCLK,
    input logic _MicData,
    output logic _MicLRSEL,
    input logic[1:0] _FSMState,
    output logic [M-1:0] _MicDataSampled,
    output logic _RECORD_DONE );
     
    assign _MicLRSEL = 1'b0; //mic LRSel
    
    // 3.125MHZ * 1s = 3125000 bits
    // log(base2)(3125000) = 21.5754

    // (2^22)bits = 4194304 bits
    // 2^22 / 3.125MHz = 1.342 sec
    
    // reg [21:0] RecordTimeCounter; // 1.3s -> 689.85% LUT memory
    // reg [20:0] RecordTimeCounter; // 0.65s -> 344.93% LUT memory
    //reg [19:0] RecordTimeCounter; // 0.325s -> 172.46% LUT memory
    reg [18:0] RecordTimeCounter; // 0.1625s -> 86.23%
    
    always @ (posedge _MicCLK)
    begin
        if (_FSMState == 2'b00)
        begin
            _MicDataSampled = _MicData;
            if (RecordTimeCounter == 19'h7FFFF) // 524287
            begin
                _RECORD_DONE = 1;
            end
            else
            begin
                _RECORD_DONE = 0;
            end
            RecordTimeCounter = RecordTimeCounter + 1;
        end
        else // Any other state
        begin
            RecordTimeCounter = 0;
        end
    end
endmodule


// Custom RAM module
// Due the the limited resources, the 8-bit sampling and fourier transform
// will be done in this module.
module RAM#(parameter N = 19, M = 1) (
    // FSM State
    input logic[1:0] _FSMState,
    
    // RECORDING
    input _RecordCLK,
    input logic [M-1:0] _DataInFromMic,
    
    // PROCESSING
    input logic _SamplingCLK32KHz,
    input logic[3:0] _PhaseIncrement, // 1, 2, 3, ..., 15
    input logic[7:0] _SineWaveSampleDataCurrentPhase,
    output logic [4:0] _Phase,
    output logic _PROCESS_DONE,
    output logic [7:0] _FourierResult,
    
    // READING
    output logic [M-1:0] _DataOutToAudio,
    output logic _READ_DONE
    );
    
    logic [N-1:0] WriteAddress;
    logic [N-1:0] ReadAddress;

    logic [M-1:0] Memory[((2**N)-1):0];
   
    always @ (posedge _RecordCLK)
    begin
        // RECORD state
        if (_FSMState == 2'b00)
        begin
            Memory[WriteAddress] = _DataInFromMic;
            WriteAddress = WriteAddress + 1;
        end        
        else // Any other state
        begin
            WriteAddress = 0;
        end
    end
    
    
    
    // PROCESSING
    logic [11:0] SampleArrayCounter;
    logic [7:0] ShiftedBy5bit;
    logic [7:0] EvenSampleAnalogVoltage;
    logic [7:0] OddSampleAnalogVoltage;
    logic [8:0] BitCounterEvenSamples; // 0 - 255, reset every 256
    logic [8:0] BitCounterOddSamples;  // 0 - 255, reset every 256
    
    logic [15:0] Sample_X_Sine;
    logic [4:0] DivBy11bits; // = Sample_X_Sine >> 11 = 5'b
    logic [16:0] Sum; // 17'b
    
    always @ (posedge _SamplingCLK32KHz)
    begin
        // PROCESS state
        if (_FSMState == 2'b01)
        begin
             if (ReadAddress == 524287)
             begin
                // Here: SUM = 16129A + 32768 = 17'b
                Sum = Sum - 32768;
                _FourierResult = Sum[7:0];
                SampleArrayCounter = 0;
                _PROCESS_DONE = 1;
            end
            else if (ReadAddress <= 127 || ReadAddress >= 524161) // Only odd
            begin
                if (BitCounterEvenSamples < 256)
                begin
                    EvenSampleAnalogVoltage = EvenSampleAnalogVoltage + Memory[ReadAddress];
                    BitCounterEvenSamples = BitCounterEvenSamples + 1;
                end
                else
                begin
                    // Even sample is ready
                    ShiftedBy5bit = { EvenSampleAnalogVoltage[2:0], 5'b00000 };
                    Sample_X_Sine = (ShiftedBy5bit * _SineWaveSampleDataCurrentPhase);
                    DivBy11bits = Sample_X_Sine >> 11;
                    Sum = Sum + DivBy11bits;
 
                    EvenSampleAnalogVoltage = 0;
                    BitCounterEvenSamples = 0;
                    SampleArrayCounter = SampleArrayCounter + 1;
                    _Phase = _Phase + _PhaseIncrement;
                end
                ReadAddress = ReadAddress + 1;
            end
            else    // (ReadAddress > 127 && ReadAddress < 524160): Odd and Even
            begin
                // 1. Even is not ready
                if (BitCounterEvenSamples < 256)
                begin
                    if (BitCounterOddSamples < 256) // 1-a. Odd is not ready
                    begin
                         OddSampleAnalogVoltage = OddSampleAnalogVoltage + Memory[ReadAddress];
                         BitCounterOddSamples = BitCounterOddSamples + 1;
                    end
                    else // 1-b.Odd is ready
                    begin
                       // Get the sine value of current phase
                       ShiftedBy5bit = { OddSampleAnalogVoltage[2:0], 5'b00000 };
                       Sample_X_Sine = (ShiftedBy5bit * _SineWaveSampleDataCurrentPhase);
                       DivBy11bits = Sample_X_Sine >> 11;
                       Sum = Sum + DivBy11bits;
                                              
                       OddSampleAnalogVoltage = 0;
                       BitCounterOddSamples = 0;
                       SampleArrayCounter = SampleArrayCounter + 1;
                       _Phase = _Phase + _PhaseIncrement;
                    end
                    EvenSampleAnalogVoltage = EvenSampleAnalogVoltage + Memory[ReadAddress];
                    BitCounterEvenSamples = BitCounterEvenSamples + 1;
                end
                else // 2. Even is ready
                begin
                    if (BitCounterOddSamples < 256) // 1-a. Odd is not ready
                    begin
                        OddSampleAnalogVoltage = OddSampleAnalogVoltage + Memory[ReadAddress];
                        BitCounterOddSamples = BitCounterOddSamples + 1;
                    end
                    else // 1-b.Odd is ready
                    begin
                        // Get the sine value of current phase
                        ShiftedBy5bit = { OddSampleAnalogVoltage[2:0], 5'b00000 };
                        Sample_X_Sine = (OddSampleAnalogVoltage * _SineWaveSampleDataCurrentPhase);
                        DivBy11bits = Sample_X_Sine >> 11;
                        Sum = Sum + DivBy11bits;

                        OddSampleAnalogVoltage = 0;
                        BitCounterOddSamples = 0;
                        SampleArrayCounter = SampleArrayCounter + 1;
                        _Phase = _Phase + _PhaseIncrement;
                    end
                     // Even sample is ready      
                    Sample_X_Sine = (EvenSampleAnalogVoltage * _SineWaveSampleDataCurrentPhase);
                    DivBy11bits = Sample_X_Sine >> 11;
                    Sum = Sum + DivBy11bits;

                    EvenSampleAnalogVoltage = 0;
                    BitCounterEvenSamples = 0;
                    SampleArrayCounter = SampleArrayCounter + 1;
                    _Phase = _Phase + _PhaseIncrement;
                end               
                ReadAddress = ReadAddress + 1;
            end
        end
        else // Any other state
        begin
            ReadAddress <= 0;
            _PROCESS_DONE <= 0;
            SampleArrayCounter <= 0;
            EvenSampleAnalogVoltage <= 0;
            OddSampleAnalogVoltage <= 0;
            BitCounterEvenSamples <= 0;
            BitCounterOddSamples <= 0;
        end
    end
endmodule


// Speaker module
// Current setting only has 0.1 sec of data
// The user will hear nearly spike
module Speaker# (parameter M = 1) (
    input logic [M-1:0] _SampledData,
    output logic _AUD_PWM,
    output logic _AUD_SD );
    
    
    assign _AUD_PWM = _SampledData;
    assign _AUD_SD = 1'b1;
endmodule


// Main Module
module Frq_Analyzer (
    input logic CLK100MHZ, // System CLK
    input logic BTNC, // Initiate the module
    input logic[3:0] SW, // Input Frequency
    
    // microphone signals
    output logic M_CLK, M_LRSEL,
    input logic M_DATA,
    
    // Monitoring Audio output signal
    output logic AUD_PWM, AUD_SD,
    output logic [15:0] LED );
    
    // Registers
    reg MicCLK_;
    reg SinWaveCLK;
    reg Mic_SampledData;
    reg [3:0] PhaseIncrement_ = 4'b0001;
    reg [4:0] Phase_;
    reg [7:0] SineWaveSampleData_;
    
    // RECORD - PROCESS - READ  -  DONE
    // 2'b00    2'b01     2'b10    2'b11
    reg [1:0] FSMState = 2'b11; // DONE state first
    reg RAM_Read;
    reg [7:0] FourierResult_;

    // Flags
    reg RECORD_DONE;
    reg PROCESS_DONE;
    reg READ_DONE;

    assign M_CLK = MicCLK_;   
    assign LED[15:14] = FSMState;
    assign LED[7:0] = FourierResult_;
    
    always_ff @ (posedge CLK100MHZ)
    begin
        case (FSMState)
        2'b00: // RECORD state
        begin
            if (RECORD_DONE)
            begin
                FSMState = 2'b01;
            end
        end
        2'b01: // PROCESS state
        begin
            if (PROCESS_DONE)
            begin
                FSMState = 2'b10;
            end
        end    
        2'b10: // READ state
        begin
            if (READ_DONE)
            begin
                FSMState = 2'b11;
            end
        end
        2'b11: // DONE state
        begin
            if (BTNC)
            begin
                FSMState = 2'b00;
            end
        end
        endcase        
    end
       

    // Module CLK generator
    CLK_Generator(
        ._SystemClock(CLK100MHZ), 
        ._MicCLK(MicCLK_),
        ._SineSampleClock(SinWaveCLK) );

    // Module Microphone
    Microphone (
         ._MicCLK(M_CLK),
         ._MicData(M_DATA),
         ._MicLRSEL(M_LRSEL),
         ._FSMState(FSMState),
         ._MicDataSampled(Mic_SampledData),
         ._RECORD_DONE(RECORD_DONE) );
         
    
    // Module RAM         
    RAM (
        // FSM state
        ._FSMState(FSMState),
        
        // RECORD state
        ._RecordCLK(MicCLK_),
        ._DataInFromMic(Mic_SampledData),
        
        // PROCESSING
        ._SamplingCLK32KHz(SinWaveCLK),
        ._PhaseIncrement(PhaseIncrement_),
        ._SineWaveSampleDataCurrentPhase(SineWaveSampleData_),
        ._Phase(Phase_),
        ._PROCESS_DONE(PROCESS_DONE),
        ._FourierResult(FourierResult_),      
        
        // READING
        ._DataOutToAudio(RAM_Read),        
        ._READ_DONE(READ_DONE)
        );
    
    // Module Speaker
    Speaker (
        ._SampledData(RAM_Read),
        ._AUD_PWM(AUD_PWM),
        ._AUD_SD(AUD_SD) );
    
    // Module SampleSineWave
    SampleSineWave (
        ._SysCLK(CLK100MHZ),
        ._Phase(Phase_),
        ._SineWaveSampleData(SineWaveSampleData_) );
endmodule