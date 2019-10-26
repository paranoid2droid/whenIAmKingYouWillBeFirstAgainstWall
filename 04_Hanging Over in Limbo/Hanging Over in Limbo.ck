// this composition consists of 4 parts
// a sequencer for drum and bass
// a sound effect flies from right to left
// and a dominant seven chord player

// patch the lines
SndBuf kick => dac;
.7 => kick.gain;
SndBuf clap => Pan2 p =>dac;
.8 => clap.gain;
SqrOsc bass => dac;
0 => bass.gain;
// chord group 
TriOsc chord[5];
Gain chordgroup => dac;
for( 0 => int i; i < chord.cap(); i++){
    chord[i] => chordgroup;
    0 => chord[i].gain;
}
// Saw for the sound effect
SawOsc saw => Pan2 pan => dac;
1 => pan.pan;
.13 => saw.gain;
// read samples
me.dir(-1) + "/audio/kick_04.wav" => kick.read;
me.dir(-1) + "/audio/clap_01.wav" => clap.read;
kick.samples() => kick.pos;
clap.samples() => clap.pos;
// prepare for the sequencer
[1,0,0,1,0,1,1,0] @=> int kick_ptrn[];
[0,1,1,0,1,0,1,0] @=> int clap_ptrn[];
[1,1,0,1,0,1,0,1] @=> int bass_ptrn[];
// I chosed a Lydian scale for the bass
[36, 38, 40, 42, 42, 42, 31, 33, 35] @=> int bass_note[];
// function for a sequencer
fun void sequencer( int kickArray[], int clapArray[], int bassArray[], float beattime ){
    for( 0 => int i; i < kickArray.cap(); i++){
        if( kickArray[i] == 1 ){
            0 => kick.pos;
        }
        if( clapArray[i] == 1 ){
            Math.random2f( -1, 1 ) => p.pan;
            0 => clap.pos;
        }
        if( bassArray[i] == 1 ){
            .1 => bass.gain;
            //randomly choose a notes from the notes set
            Math.random2( 0, bass_note.cap()-1 ) => int j;
            Std.mtof(bass_note[j]) => bass.freq;
        }
        if( bassArray[i] == 0 ){
            0 => bass.gain;
        }
        // use module to make the rhythm more complicated
        if( i%3 == 2 ) beattime/3 => beattime;
        if( i%6 == 1 ) beattime*2 => beattime;
        beattime::second => now;
    }
}

// a function for a "falling" sound effect
fun float falling( float jumpoint ){
    // monitor the program
    <<< jumpoint >>>;
    // use the method of recursive coding
    if( jumpoint >= 20 ){
        jumpoint => saw.freq;
        // right to left
        pan.pan() - 2/(jumpoint/10) => pan.pan;
        7::ms => now;
        // recurse
        return falling( jumpoint/1.02 );      
    }
    else if ( jumpoint < 20 ){
        // back to the start
        1 => pan.pan;
        return( 20.0 );
    }    
}   

// a function for dominant seven chord
fun void play7Chord( int root, string quality, float length ){
    // try appropriate gains
    for( 0 => int i; i < chord.cap()-2; i++){
    .05 => chord[i].gain;
    }
    .11 => chord[3].gain;
    .09 => chord[4].gain;

    // root note
    Std.mtof(root) => chord[0].freq;
    // 3rd note which can change the quality of the chord
    if( quality == "major"){
        Std.mtof(root+4) => chord[1].freq;
    }
    if( quality == "minor"){
        Std.mtof(root+3) => chord[1].freq;
    }
    // 5th note
    Std.mtof(root+7) => chord[2].freq;
    // for the 7th note in chord, we introduce some tremolo effects
    Std.mtof(root+11)-2 => chord[3].freq;
    Std.mtof(root+11)+3 => chord[4].freq;
    
    length::ms => now;
}

// start to loop
9 => int loop;
for(0 => int l; l < loop; l++  ){
    falling( 3333 );
    sequencer( kick_ptrn, clap_ptrn, bass_ptrn, .33 );
    Math.random2(48, 66) => int k;
    play7Chord( k, "major", 999);
    falling( Math.random2(179,333) );
}

falling( 14233 );