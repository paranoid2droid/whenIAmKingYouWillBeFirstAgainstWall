// drums.ck

// route
SndBuf kick => dac;
SndBuf snare => JCRev r => dac;
SndBuf hihat => Echo echo => dac;

// set parameters
.02 => r.mix;
.42 => echo.mix;
75::ms => echo.delay => echo.max;

// load samples needed
me.dir(-1) + "/audio/kick_03.wav" => kick.read;
me.dir(-1) + "/audio/snare_03.wav" => snare.read;
me.dir(-1) + "/audio/hihat_02.wav" => hihat.read;
kick.samples() => kick.pos;
snare.samples() => snare.pos;
hihat.samples() => hihat.pos;

// a tender drum set
.4 => kick.gain;
.3 => snare.gain;
.1 => hihat.gain;

// loop
while( true ){
    // kick and hihat
    Math.random2f(.2, .3) => hihat.gain;
    Math.random2( 0, hihat.samples()/3 ) => hihat.pos;
    Math.random2f(.2, .3) => kick.gain;
    0 => hihat.pos;
    .25::second => now;
    
    // add some swing feel
    Math.random2f(.1, .2) => hihat.gain;
    Math.random2f(.9,1.1) => hihat.rate;    
    (Math.random2(1, 2) * 0.25)::second => now;
    Math.random2( 0, hihat.samples()/3 ) => hihat.pos;
    if( maybe ) 0 => snare.pos;
    
    // add more swing
    Math.random2f(.1, .2) => kick.gain;
    Math.random2f(.8,1.1) => snare.rate;    
    Math.random2f(.2, .3) => snare.gain;
    (Math.random2(1, 4) * 0.125)::second => now;
    Math.random2( 0, hihat.samples()/3 ) => hihat.pos;
    if( maybe ) 0 => hihat.pos;
    if( maybe ) 0 => snare.pos;
    if( maybe ) 0 => kick.pos;
}