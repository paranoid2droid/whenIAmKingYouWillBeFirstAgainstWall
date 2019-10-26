// bass.ck

// Route
StifKarp bass => LPF l => NRev r => dac;

//set prameters
666 => l.freq;
0.1 => r.mix;
//.3 => bass.pickupPosition;
.99 => bass.baseLoopGain;

// notes for bass walking
[ [60, 64, 67, 70],
  [65, 69, 72, 75],
  [67, 71, 74, 77] ] @=> int chords[][];
  
// loop
while( true ){
    // 4-th walking notes
    4 => int notesperbar;
    
    // set the chord progression by hand
    repeat( 4*notesperbar ){
        Std.mtof( chords[0][Math.random2(0,3)] -36) => bass.freq;
        Math.random2f(0.2,0.8) => bass.pickupPosition;
        .42 => bass.noteOn;
        .42::second => now;
        .1 => bass.noteOff;
        .08::second => now;
    }
    
    repeat( 2*notesperbar ){
        Std.mtof( chords[1][Math.random2(0,3)] -24) => bass.freq;
        Math.random2f(0.2,0.8) => bass.pickupPosition;
        .42 => bass.noteOn;
        .42::second => now;
        .1 => bass.noteOff;
        .08::second => now;
    }
    
    repeat( 2*notesperbar ){
        Std.mtof( chords[0][Math.random2(0,3)] -24) => bass.freq;
        Math.random2f(0.2,0.8) => bass.pickupPosition;
        .42 => bass.noteOn;
        .42::second => now;
        .1 => bass.noteOff;
        .08::second => now;
    }
    
    repeat( 2*notesperbar ){
        Std.mtof( chords[2][Math.random2(0,3)] -24) => bass.freq;
        Math.random2f(0.2,0.8) => bass.pickupPosition;
        .42 => bass.noteOn;
        .42::second => now;
        .1 => bass.noteOff;
        .08::second => now;
    }
    
    repeat( 2*notesperbar ){
        Std.mtof( chords[1][Math.random2(0,3)] -24) => bass.freq;
        Math.random2f(0.2,0.8) => bass.pickupPosition;
        .42 => bass.noteOn;
        .42::second => now;
        .1 => bass.noteOff;
        .08::second => now;
    }
}
    