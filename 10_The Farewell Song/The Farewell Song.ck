// Additive Modal Synthesis using BiQuad ResonZ filter
//    to resynthesize the plinked Plate sound
// Credits to Perry R. Cook

// A song played by the physics-based modeling triangle I've made
// It is a famous song named "Farewell Song"(Chinese "Songbie"), 
// Chinese artist Hong Yi(Li Shutong) arranged the lyrics to the song "Dreaming of Home and Mother" by American composer John P. Ordway.
// In the first section is the melody and the second I added some triangle beats.
// Also some panning.
// by Zhe Zhang, 2018.10

// Modal Resynthsis Class, uses ResonZ filters for modes
class ModalSynth extends Chubgraph {
    15 => int NUM_MODES; // I chosed 15 modes here
    ResonZ modes[NUM_MODES];

//     frequency  ,  gain  , and the time constants
    // 5 modes are throwed away because the energy is too little or they decay too fast
    // I chosed these time constants by watching the spectrogram
    [[ 9601.116943 , 0.900000 , 1.5 ], 
     [ 1892.230225 , 0.423665 , 4.2 ], 
     [ 5162.585449 , 0.095920 , 2.2 ], 
     [ 11687.145996 , 0.039921, 0.1 ], 
     [ 3566.436768 , 0.034507 , 3.6 ], 
     [ 8594.439697 , 0.014335 , 0.5 ], 
     [ 8917.437744 , 0.058463 , 0.7 ], 
     [ 1641.906738 , 0.046168 , 0.5 ], 
     [ 9555.358887 , 0.022482 , 1.1 ], 
     [ 4220.507813 , 0.028623 , 1.6 ], 
     [ 11522.955322 , 0.035115, 0.2 ], 
     //[ 15377.398682 , 0.000888 ], 
     [ 9644.183350 , 0.011289 , 0.6 ], 
     [ 6441.119385 , 0.001003 , 2.5 ], 
     //[ 9703.399658 , 0.005354 ], 
     //[ 9504.217529 , 0.003324 ], 
     [ 8548.681641 , 0.002100 , 0.5 ], 
     //[ 9458.459473 , 0.001143 ], 
     //[ 15232.049561 , 0.001207 ], 
     [ 12435.424805 , 0.006377 , 0.6 ]]
     @=> float freqsNamps[][];

//    You could fill this array with measured or guess-timated time constants
// [ 2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1 ] @=> float T60s[];
//   or build them in as a third number for each entry above
//   see code below on how to use them.

// use this for residual (or other wave file) excitation
//     NOTE:   See residue file note above
    
// Use this for enveloped noise excitation
Noise n => ADSR excite;
Pan2 p; //declare the panner
(samp,10::ms,0.0,ms) => excite.set;

// Or use this for an impulse excitation
//  Impulse imp => Gain excite
// // when you want to excite it, do:  100*vel => imp.next; // or some scaled version

// might have to fiddle with this some, depends on modes and excitation
    22.0 => excite.gain;

    for (int i; i < NUM_MODES; i++)  {
        excite => modes[i] => p =>dac; // add the panner here
        freqsNamps[i][0] => modes[i].freq; // frequencies from 
        // use the t60s in the modes to decide the Qs
        setQfromT60(freqsNamps[i][2],freqsNamps[i][0]) => modes[i].Q;  
        freqsNamps[i][1] => modes[i].gain;
    }

    fun float setQfromT60 (float tsixty, float centerFreq)  {  
        Math.pow(10.0,-3.0/(tsixty*second/samp)) => float rad;
        Math.log(rad) / -pi / (samp/second) => float BW;
        centerFreq / BW => float Q;
//        <<< "BW is", BW, "Q is", Q >>>;
        return Q;
    }

    fun void whackIt()  {
//        <<< modes[0].gain(), modes[1].gain(), modes[2].gain(), modes[3].gain(), modes[4].gain() >>>;
        1 => excite.keyOn; // for enveloped noise excitation
    }
    
    fun void whackItRandom(float vel)  {
        for (int i; i < 15; i++)  {  // randomize the mode gains a bit
            vel*Math.random2f(freqsNamps[i][1]/2,2*freqsNamps[i][1]) => modes[i].gain;
        }
        whackIt();
    }

    fun void whackIt(float vel)  {
        for (int i; i < 15; i++)  {  // assume lots about spatial modes
            vel*Math.random2f(freqsNamps[i][1]/2,1.2*freqsNamps[i][1]) => modes[i].gain;
        }
        whackIt();
    }

    // overloaded function uses position (0-1.0) for mode gains
    //   makes gross assumption that modes are 1D spatial modes
    fun void whackIt(float vel, float position)  {
        for (int i; i < NUM_MODES; i++)  {
            freqsNamps[i][0] => modes[i].freq;
            Math.sin(pi*(i+1)*position) => float temp;
            vel*temp*freqsNamps[i][1] => modes[i].gain;
        }
        whackIt();
     }
     
     fun void whackIt(float pitch, float velocity, float position)  {
         for (int i; i < NUM_MODES; i++)  {
             pitch/440*freqsNamps[i][0] => modes[i].freq;
             Math.sin(pi*(i+1)*position/NUM_MODES) => float temp;
             velocity*temp*freqsNamps[i][1] => modes[i].gain;
         }
         whackIt();
     }
     
     // this is my modified wahckIt function with parameters controlling the ADSR
     fun void whackIt(float pitch, dur attack, dur decay, float sustain, dur release)  {
         for (int i; i < NUM_MODES; i++)  {
             pitch/440*freqsNamps[i][0] => modes[i].freq; //"Normalize" the pitch to a appropriate frequency
             Math.random2f(freqsNamps[i][1]/3,freqsNamps[i][1]) => modes[i].gain;
             (attack, decay, sustain, release) => excite.set;
         }
         whackIt();
     }
     
 }


// Ready to kick ass!!!
 
ModalSynth triangle;

 
// tempo and melodies
625::ms => dur q;
 
[67,  64,  67,  72,  69,  72,  67,  67,  60,  62,  64,  62,  60,  62] @=> int phrase1[];
[ q, q/2, q/2, 2*q,   q,   q, 2*q,   q, q/2, q/2,   q, q/2, q/2, 4*q] @=> dur durs1[];  // durations

[67,  64,  67,   72,  71,  69,  72,  67,  67,  62,  64,  65,  59,  60,  64,  67] @=> int phrase2[];
[ q, q/2, q/2,1.5*q, q/2,   q,   q, 2*q,   q, q/2, q/2,  q,    q, 2*q,   q,   q] @=> dur durs2[];  // durations

[69,  72,  72,   71,  69,  71,  72,  69,  71,  72,  69,  69,  67,  64,  60,  62,
 67,  64,  69,   72,  71,  69,  72,  67,  67,  62,  65,  59,  60] @=> int section2[];
[ q,   q, 2*q,    q, q/2, q/2, 2*q, q/2, q/2, q/2, q/2,  q/2,q/2, q/2, q/2,  4*q,
  q, q/2, q/2,1.5*q,  q/2,  q,   q, 2*q,   q,   q,   q,   q, 4*q] @=> dur sectiondur[];  // durations

second => now;

for (1 => int i; i < 8; i++) { // test "strike position" function
    triangle.whackIt(0.5,i/20.0);  // move along "length" of bar (if it were a bar)
    625::ms => now;
}

3::second => now;

// the pitch and durations of notes also controls the ADSR parameters
0 => int i;
while (i < phrase1.cap())  {    
    triangle.whackIt(Std.mtof(phrase1[i]), durs1[i]/500, durs1[i]/100, phrase1[i]/400, durs1[Std.abs(i-1)]/200); // use your pitch here
    durs1[i] => now;    
    i++;
}

0 => i;
while (i < phrase2.cap())  {    
    triangle.whackIt(Std.mtof(phrase2[i]), durs2[i]/500, durs2[i]/100, phrase2[i]/400, durs2[Std.abs(i-1)]/200); // use your pitch here
    durs2[i] => now;    
    i++;
}

// play beats on the left
ModalSynth triangleL;
-.8 => triangleL.p.pan;

ModalSynth triangleR;

now + 20::second => time then;

// sporkkkkkk
spork ~ do2();

0 => i;
while (now < then)  {
    Math.random2f(0, 1) => triangleR.p.pan;
    triangleR.whackIt(Std.mtof(section2[i]), sectiondur[i]/500, sectiondur[i]/100, section2[i]/400, sectiondur[Std.abs(i-1)]/200); // use your pitch here
    sectiondur[i] => now;    
    i++;
    
}

3::second => now;

triangle.whackIt();

7::second => now;

fun void do2() {    
    while (now < then)  {
        triangleL.whackIt(.66);
        q/2 => now;
        triangleL.whackIt(Math.random2f(0.22, 0.42), Math.random2f(0, 1));    
        q/4 => now;
        triangleL.whackIt(Math.random2f(0.22, 0.42), Math.random2f(0, 1));    
        q/4 => now;        
    }    
}

