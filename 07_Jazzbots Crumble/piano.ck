// piano.ck
// sound chain
Rhodey piano[3] => Pan2 pan => dac;
// a Rhode played by 3 hands, trickly
.4 => piano[0].gain;
.5 => piano[1].gain;
.6 => piano[2].gain;
2 => piano[1].controlOne;
3 => piano[2].controlTwo;

// scale for piano
[55, 56, 58, 59, 60, 64, 65, 67, 69, 70, 72, 74, 75, 77]
    @=> int notes[];

[7, 7, 7] @=> int walkPos[];

// loop 
while( true )  
{
    for( 0 => int i; i<3 ; i++){
        // jamming on the keyboard
        if( Math.random2f(0, .7) > .2 ){
            //if( walkPos[i] < 0 ) 3 => walkPos[i];
            //if( walkPos[i] > notes.cap()-1 ) 7 => walkPos[i];
            //Math.random2( -2, 2 ) +=> walkPos[i];
            Math.random2( 0, notes.cap()-1 ) => walkPos[i];

            Std.mtof( notes[walkPos[i]] ) => piano[i].freq;
            //<<<walkPos[i]>>>;
            //<<<0 + (walkPos[i]+1)*2.0/notes.cap()>>>;
            //<<<pan.pan()>>>;
            (-0.5 + (walkPos[i])/notes.cap())/3 => pan.pan;
            Math.random2f(.2, .6) => piano[i].noteOn;
        }
        else 1 => piano[i].noteOff;
    }
    ( Math.random2(1, 4) * .125 )::second => now;
}
