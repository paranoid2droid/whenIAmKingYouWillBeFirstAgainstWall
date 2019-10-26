// drums.ck
BPM tempo;
SCALE player;
// sound chain
SndBuf kick => dac;

//
me.dir(-1) + "audio/kick_02.wav" => kick.read;

// parameter setup
.5 => kick.gain;

// loop 
while( true )  
{
    Math.random2f(0.36, 0.42) => kick.gain;
    Math.random2f(.9,1.1) => kick.rate;
    tempo.eighthNote => now;
    0 => kick.pos;
}
