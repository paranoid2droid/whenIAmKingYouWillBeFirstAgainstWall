// Additive Modal Synthesis using BiQuad ResonZ filter
//    to resynthesize the plinked Plate sound
// by Perry R. Cook, 2015

// A physics-based modeling triangle
// However, the triangle has a very long decay time...
// I somehow 'mute' it a bit here.
// by Zhe Zhang, 2018.10

// Modal Resynthsis Class, uses ResonZ filters for modes
class ModalSynth extends Chubgraph {
    15 => int NUM_MODES; // I chosed 15 modes here
    ResonZ modes[NUM_MODES];

//     frequency  ,  gain  , and the time constants
    // 5 modes are throwed away because the energy is too little or they decay too fast
    // I chosed these time constants by watching the spectrogram
    [[ 9601.116943 , 0.900000 , 1.5 ], 
     [ 1892.230225 , 0.243665 , 4.2 ], 
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
(samp,10::ms,0.0,ms) => excite.set;

// Or use this for an impulse excitation
//  Impulse imp => Gain excite
// // when you want to excite it, do:  100*vel => imp.next; // or some scaled version

// might have to fiddle with this some, depends on modes and excitation
    100.0 => excite.gain;

    for (int i; i < NUM_MODES; i++)  {
        excite => modes[i] => dac;
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
            vel*Math.random2f(freqsNamps[i][1]/2,2*freqsNamps[i][1]) => modes[i].gain;
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
             pitch*freqsNamps[i][0] => modes[i].freq;
             Math.sin(pi*(i+1)*position/NUM_MODES) => float temp;
             velocity*temp*freqsNamps[i][1] => modes[i].gain;
         }
         whackIt();
     }
     
 }

// I kicked slower beats because the decay of triangle is pretty long
// although I have shortened it
ModalSynth triangle;

triangle.whackIt();

5*second => now;
for (1 => int i; i < 11; i++) { // test "strike position" function
    triangle.whackIt(0.5,i/20.0);  // move along "length" of bar (if it were a bar)
    <<< "Whack it at:", i/20.0 >>>;
    second => now;
}
3*second => now;

// now try out some pitch transpositions for a bit

now + 20::second => time then;

while (now < then)  {
    triangle.whackIt(Math.random2f(0.7,1.6), 0.5, 0.34159);
    (Math.random2f(1,3)*0.5)::second => now;
}

