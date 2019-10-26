// A wave pusher
// White noise passing low pass filter

public class Wave extends Chubgraph {
    Noise n => ADSR a => LPF l => NRev r => Pan2 p => dac;

    .2 => r.mix;
    
    // different cut off and pan
    Math.random2f(2200,4200) => l.freq;
    Math.random2f(-1.0,1.0) => p.pan;
    
    // parameter setting function
    fun void setADSR( dur attack, dur decay, float sustain, dur release ){
        ( attack, decay, sustain, release ) => a.set;
    }

    // swell function
    fun void swell()  {
        Math.random2f(0.2/5, 0.8/5) => n.gain;
        1 => a.keyOn;
        Math.random2f(2, 3) :: second => now;
	    1 => a.keyOff;
        Math.random2f(2, 3) :: second => now;
    }
}

// test
//Wave wv => dac; 
//wv.setADSR( 500::ms, 700::ms, .1 , 200::ms );
//wv.swell();


