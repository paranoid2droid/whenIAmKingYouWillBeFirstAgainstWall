//----------------------------|
// Chupter 0
// 
// by Zhe
//
// a brute silly program as a starter
//
//--------------------------------------|

// synchronize to period

1::second => dur T;
T - (now % T) => now;

// connect patch
SinOsc s => JCRev r => dac;


// scale (in semitones)
[ 0, 2, 4, 5, 7, 9, 11, 12 ] @=> int scale[];
[ 0,    4,    7,        12 ] @=> int Cmaj[];
[    2,    5,    9,     12 ] @=> int D7[];
[    2,    5, 7,    11     ] @=> int G7[];
// C# actually because midi index is 22

<<< "CCRMA POLICE, arrest this man he talks in math!" >>>;

5 => int loop;
// infinite time loop
for( 0 => int i; i < loop; i++  ){
    int chord[];
    
    scale @=> chord;
    now + 5::second => time bar;
    //<<<now / second>>>;
    .1 => r.mix;
    .1 => s.gain;
    
    while( now < bar ){
         // get note class
        chord[ Math.random2(0, chord.cap()-1 ) ] => float freq;
        // get the final freq    
        Std.mtof( 22.0 + (Std.rand2(1,4)*12 + freq) ) => s.freq;
        // 0 => s.phase;

        // advance time
        if( Std.randf() > 0)
            .25::T => now;
        else
            .5::T => now;
    }

    
    D7 @=> chord;
    .2 => r.mix;
    now + 5::second => time bar1;
        while( now < bar1 ){
         // get note class
        chord[ Math.random2(0, chord.cap()-1 ) ] => float freq;
        // get the final freq    
        Std.mtof( 22.0 + (Std.rand2(2,4)*12 + freq) ) => s.freq;
        0 => s.phase;

        // advance time
        if( Std.randf() > -.5)
            .25::T => now;
        else
            .75::T => now;
        }
        
    G7 @=> chord;
    .3 => r.mix;
    now + 5::second => time bar2;
        while( now < bar2 ){
         // get note class
        chord[ Math.random2(0, chord.cap()-1 ) ] => float freq;
        // get the final freq    
        Std.mtof( 22.0 + (Std.rand2(3,4)*12 + freq) ) => s.freq;
        90 => s.phase;

        // advance time
        if( Std.randf() > -.5)
            .25::T => now;
        else
            1::T => now;
    }
    
    Cmaj @=> chord;
    now + 5::second => time bar3;
    .6 => r.mix;
    
    while( now < bar3 ){
         // get note class
        chord[ Math.random2(0, chord.cap()-1 ) ] => float freq;
        // get the final freq    
        Std.mtof( 22.0 + (Std.rand2(4,4)*12 + freq) ) => s.freq;
        180 => s.phase;

        // advance time
        if( Std.randf() > -.5)
            .25::T => now;
        else
            .25::T => now;
    }
    
        //rev mod
    now + 5::second => time bar4;
    1 => r.mix;
    1 => float d;
    .1 => float g;
    
    while( now < bar4){
        .8/200 -=> d;
        .1/500 -=> g;
        <<<g>>>;
        d => r.mix;
        g => s.gain;
        20::ms => now;
    }
    

}