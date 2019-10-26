// title: Precode in C
// by Zhe Zhang, when September ends, 2018
// a tribute to J.S.Bach
// As the title goes, it is motivated by the first 4 bars of BWV 846
// Generally it has 3 timbres, a bass, a lead, and a kind of sound effect
// with the 2-5-1 harmonic progress you can easily figure out by bass
// I spend some time on manipulating the time in order to 
// generate different duration in the same time
// There must be easier way to realise it, hope to learn it soon
// Thanks

<<< "Zhe Zhang" >>>;

// patch and mix
SqrOsc Sqr => Pan2 pan => dac;
.1/3 => Sqr.gain;
TriOsc Tri => dac;
.6/3 => Tri.gain;
SinOsc Sin => Pan2 panr =>dac;
.3/3 => Sin.gain;


// notes set
// bass notes C D G and a higher C, indicating the 2-5-1
[48, 38, 43, 36] @=> int Bass[];
// a C major scale for the lead
[59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76, 77, 79] @=> int Lead[];
// a C chromatic scale for the effect
[84, 85, 86, 87, 88, 89, 90 ,91, 92, 93, 94, 95, 96] @=> int Treble[];

// a counting integer to calculate the harmonic progress
0 => int n;
8 => int loop;

// main loop
for ( 0 => int l; l < loop*4; l++ ){
    // monitor the bar in console
    <<< n%4 >>>;
    // initial lead pan in left
    -1.0 => float p;
    
    // 2 seconds for a bar
    now + 2::second => time bar;
    while( now < bar ){
        // bass plays C D G and higher C        
        Std.mtof( Bass[n%4] ) => Tri.freq;
        
        // 0.25 seconds for a beat, 8 beats per bar
        now + .25::second => time beat;
        while( now < beat ){
            // randomly choose a note in C major scale
            Lead[ Math.random2(0, Lead.cap()-1 ) ] => int pitch;
            // and convert the midi number to frequency
            Std.mtof( pitch ) => Sqr.freq; 
            // pan the melody from left to right
            p => pan.pan;
            .25 +=> p; 

            // play 16 times per beats
            for ( 0 => int i; i<16; i++ ){
                // add some expression in random
                if ( i == 11 )
                    Std.mtof( 95 ) => Sin.freq;
                // add some rhythm in the random
                else if( i % 7 == 0 )
                    Std.mtof( 47 ) => Sin.freq;
                else{                
                    // randomly choose a note in C chromatic scale
                    Treble[ Math.random2(0, Lead.cap()-1 ) ] => int rand;
                    // midi to frequency
                    Std.mtof( rand ) => Sin.freq;
                    // use a tangent function to modulate the pan of rapid sine wav
                    // I tried sin fuction to compare, using sine is more smooth feeling
                    // while tan causing a value >1, and the sound more frequently locate in left and right
                    // and the tan is causing some clip, I think it may be a result of rapid change of phase 
                    // but I'm not sure
                    // anyway it sounds ok to me, so I keep this.
                    Math.tan(- 2 * pi * (now / 1::second) ) => panr.pan;
                }
                15.625::ms => now;
            }
       }
    }
    // don't forget to count the bar
    n++;
}

