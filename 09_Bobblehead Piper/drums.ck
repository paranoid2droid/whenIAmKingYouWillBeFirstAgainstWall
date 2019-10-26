// drums.ck

// sound chain
SndBuf kick => dac;
SndBuf click => Echo eco => Gain clickgain => Pan2 p => dac;

BPM tempo;

// me.dirUp 
me.dir(-1) + "/audio/kick_02.wav" => kick.read;
me.dir(-1) + "/audio/click_02.wav" => click.read;

// parameter setup
kick.samples() => kick.pos;
click.samples() => click.pos;
.7 => eco.mix;
.7 => clickgain.gain;
.7 => click.gain;

0 => int count;

// loop 
while( true )  
{
    count%16 => int temp;
    if( temp%2 ){
        
        Math.random2f(0.36, 0.42) => kick.gain;
        Math.random2f(.9,1.1) => kick.rate;
        0 => kick.pos;
    }
    
    if( Math.random2f(0, 1) < 0.618 ){
        Math.random2f(-0.6, 0.6) => p.pan;
        8.0/temp => float rate;
        if (maybe) -rate => rate;
        rate => click.rate;
        temp*1000  => click.pos;
        //0 => click.pos;
    }
    
    tempo.sixteenthNote => now;
    count++;
}
