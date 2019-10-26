TriOsc pad[4];
Pan2 pan => Delay d => PRCRev r => dac;
d => d;

.36 => d.gain;
42::ms => d.delay => d.max;
.73 => r.mix;


pad[0] => pan.right;
pad[1] => pan; 
pad[2] => pan;
pad[3] => pan.left; 



for( 0 => int i; i<4; i++){
    0 => pad[i].gain;
}

[ [60, 64, 67, 70],
  [65, 69, 72, 75],
  [67, 71, 74, 77] ] @=> int chords[][];

while( true ){
    int i;
    
    for( 0 => i; i<4; i++ ){
        ( Std.mtof(chords[0][i] - 12) + Math.random2f(-2, 2) ) => pad[i].freq;
        Math.random2f(.1, .3) => pad[i].gain;
    }
    8::second => now;
    for( 0 => i; i<4; i++ ){
        ( Std.mtof(chords[1][i] - 12) + Math.random2f(-2, 2) ) => pad[i].freq;
        Math.random2f(.1, .3) => pad[i].gain;
    }
    4::second => now;
    for( 0 => i; i<4; i++ ){
        ( Std.mtof(chords[0][i] - 12) + Math.random2f(-2, 2) ) => pad[i].freq;
        Math.random2f(.1, .3) => pad[i].gain;
    }
    4::second => now;
    for( 0 => i; i<4; i++ ){
        ( Std.mtof(chords[2][i] - 12) + Math.random2f(-2, 2) ) => pad[i].freq;
        Math.random2f(.1, .3) => pad[i].gain;
    }
    2::second => now;
    for( 0 => i; i<4; i++ ){
        ( Std.mtof(chords[1][i] - 12) + Math.random2f(-2, 2) ) => pad[i].freq;
        Math.random2f(.1, .3) => pad[i].gain;
    }
    2::second => now;
    for( 0 => i; i<4; i++ ){
        ( Std.mtof(chords[0][i] - 12) + Math.random2f(-2, 2) ) => pad[i].freq;
        Math.random2f(.2, .3) => pad[i].gain;
    }
    4::second => now;
}