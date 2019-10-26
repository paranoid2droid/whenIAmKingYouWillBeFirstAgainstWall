// arp.ck
BPM tempo;
SCALE player;

// melodies using triangle waves
TriOsc arp[4];
Pan2 pan => Delay d => PRCRev r => dac;
//d => d;

.42 => d.gain;
42::ms => d.delay => d.max;
.1 => r.mix;
.9 => r.gain;

arp[0] => pan.right;
arp[1] => pan; 
arp[2] => pan;
arp[3] => pan.left; 

for( 0 => int i; i<4; i++){
    0 => arp[i].gain;
}

// change the delay line and the reverb
spork ~ moving();

while( true ){
    [SCALE.note1, SCALE.note2, SCALE.note3, SCALE.note4, 
    SCALE.note5, SCALE.note6, SCALE.note7, SCALE.note8] @=> int scale[];

    int i;
    // randomly play the notes in the scale
    for( 0 => i; i<4; i++ ){
        Math.random2(0, scale.cap()-1) => int temp;
        ( Std.mtof(scale[temp]+12) + Math.random2f(-2, 2) ) => arp[i].freq;
        Math.random2f(.1, .2) => arp[i].gain;
        if( Math.random2f(0, 1) > 0.618 ) tempo.thirtysecondNote => now;
        else tempo.sixteenthNote => now;   
    }
     
}

// change the reverb mix so that the shaker moves far and near
fun void moving(){
    while( true ){
        if( Math.random2f(0, 1) > 0.618 ){
            Math.random2f(.36, .42) => d.gain;
            Math.random2f(.22, .42) => r.mix;
            tempo.quarterNote => now;
        }
    }
}