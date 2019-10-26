// Simple Subtractive Formant Voice Model
// by Perry R. Cook, 1985-2015
//   yep, I've been working on speech synthesis that long.
// You could make this much better, it's just a starting point

public class FormantVoice extends Chubgraph   {
    SndBuf glot => Gain inV;            // voiced source
    "special:glot_pop" => glot.read;
//    BlitSaw glot => Gain inV;  // could use a sawtooth if you like
    Noise nz => OnePole p => Gain inU;  // unvoiced (whisper) source

    ResonZ form[3];    // NOTE:  form[0]-form[2] is f1-f3

    Gain out => outlet; // master mixer to dac spigot
    
    3.0 => out.gain;
    
    nz => Gain inC => ResonZ fric1 => Gain outMix => out; // consonants
    inC => ResonZ fric2 => outMix;  20 => fric1.Q => fric2.Q;

    // Targets, set these and the smoother drives toward them
    // pitch=f0, then three formants f1, f2, f3
      [150.0, 550, 800, 2390] @=> float f[];
    0.0 => float vGain => inV.gain; // voiced source gain
    0.0 => float uGain => inU.gain; // unvoiced noise gain
    0.0 => float cGain => inC.gain; // consonant noise gain
    1.0 => float myGain => outMix.gain;

    for (int i; i < 3; i++)  {
        inV => form[i] => outMix;
        inU => form[i];
        30 => form[i].Q;
        f[i+1] => form[i].freq;
    }

    220.0 => float ptch; // actual current pitch
    0.95 => float pitchSmooth;   // smooth pitch changes
    0.90 => float formSmooth;   // and smooth them formants
    0.90 => float voiceSmooth;  // and smooth voice source gain
    0.90 => float noiseSmooth;  // and smooth noise source gain
    0.90 => float consSmooth;   // and smooth consonant gain
    0.95 => float gainSmooth;
    
    6.0 => float vibFreq; // vibrato frequency (can set this immediately)
    0.01 => float vibrato; // vibrato amount (this too, within reason)
    
    1.0 => float hSize;  // scales all formants 

    1 => int notDone;
    
    spork ~ smoothStuff();
    spork ~ loopVoiced();
    
    fun void formants(float f1, float f2, float f3)  { // new formant targets
        if (f1 > 0) { hSize*f1 => f[1]; 1.0 => form[0].gain; }
        else { 0.0 => form[0].gain; }
        if (f2 > 0) { hSize*f2 => f[2]; 0.7 => form[1].gain; }
        else { 0.0 => form[1].gain; }
        if (f3 > 0) { hSize*f3 => f[3]; 0.5 => form[2].gain; }
        else { 0.0 => form[2].gain; }
    }

    fun void formantsNow(float f1, float f2, float f3)  { // set formants NOW!
        formants(f1,f2,f3);
        f[1] => form[0].freq; f[2] => form[1].freq; f[3] => form[2].freq;
    }
    
    fun void fricatives(float f1, float f2)  { // set resonances for fricative
        Math.sqrt(hSize)*f1 => fric1.freq;
        Math.sqrt(hSize)*f2 => fric2.freq;
    }
   
    fun float gain(float gn) { gn => myGain; }             // set gain target
    fun float pitch(float pt)  { pt => f[0]; return pt; } // set pitch target
    fun float pitchNow(float pt) {pt => f[0] => ptch; } // set immediately
    fun float voiced(float vg) { vg => vGain; return vg; } // set voiced gain target
    fun float voicedNow(float vg) { vg => vGain => inV.gain; return vg; } // set immediately
    fun float unVoiced(float ug) { ug => uGain; return ug; } // set unvoiced gain target
    fun float unVoiced(float ug) { ug => uGain => inU.gain; return ug; } // set immediately
    fun float consonant(float cg) { cg => cGain; return cg; } // set consonant target
    fun float consonantNow(float cg) { cg => cGain => inC.gain; return cg; } // set immediately 
    fun float headSize(float hs) { 
        if (hs < 0.1) { 0.1 => hSize; <<< "Head Size Too Small!!", "Setting to 0.1" >>>; } 
        else 1.0/hs => hSize;
    }
    fun void loopVoiced()  { 
        while (notDone)    {            
            Math.random2f(0.99,1.01) => glot.rate; // for a little bit of shimmer
            0 => glot.pos;  // make a pop
            // add vibrato into period
            ptch*(1.0+vibrato*Math.sin(2*pi*vibFreq*(now/second))) => float temp;
            second/temp => now;
        }
    }
    
    fun void smoothStuff()  {
        while (notDone)   {
            ptch*pitchSmooth + f[0]*(1-pitchSmooth) => ptch;
            for (int i; i < 3; i++)  {
                form[i].freq()*formSmooth + f[i]*(1-formSmooth) => form[i].freq;
                form[i].freq() / 100 => form[i].Q;
            }
            inV.gain()*voiceSmooth + vGain*(1-voiceSmooth) => inV.gain;
            inU.gain()*noiseSmooth + uGain*(1-noiseSmooth) => inU.gain;
            inC.gain()*consSmooth + cGain*(1-consSmooth) => inC.gain;
            outMix.gain()*gainSmooth + myGain*(1-gainSmooth) => outMix.gain;
            ms => now;
        }
    }
    
    ["eee","ihh","ehh","aah","ahh","aww","ohh","uhh","uuu","ooo"] @=> string vowelNames[];
    ["rrr","lll","mmm","nnn","nng"] @=> string liquidNames[];
    ["bbb","ddd","ggg"] @=> string stopNames[];
    ["djj","vvv","zzz","tzz","zhh","gxx"] @=> string voicedFricNames[];
    ["fff","sss","thh","shh","cxh","xxx","hee","hah","hoo"] @=> string fricativeNames[];
    ["ppp","ttt","kkk","koo"] @=> string plosiveNames[];

    [[250,2600,3010], [440,2500,2550], [620,2370,2480], // eee, ihh, ehh
    [810,1950,2410], [850,1500,2440], [810,1170,2410], // aaa, ahh, aww
    [650,1000,2400], [550,800,2390], [480,112,2240],    // ohh, uhh, uuu
    [300,870,2240]] @=> int vowels[][]; // ooo
    [[450,1500,1690], [360,1200,1864],  // rrr, lll
    [261,1175,2637], [120,1290,1960], [208,1568,2489]] // mmm, nnn, nng
                    @=> int liquids[][]; 
    [[80,-1,-1], [150,-1,-1], [200,-1,-1]]   // bbb, ddd, ggg (need better here)
                    @=> int stops[][];
    [[100,-1,-1,2600,5200], [100,-1,-1,5000,1300], // djj, vvv, (need better here) 
    [100,-1,-1,5500,9700],[100,-1,-1,4800,7500], // zzz, tzz
    [100,-1,-1,2600,5200], [100,-1,-1,920,2200]] // zhh, gxx (need better here)
                        @=> int voicedFrics[][];  // negative means set formant gain to zero
    [[5000,13000],[5500,9700],[4800,7500],[2600,5200], // fff, sss, thh, shh,
    [1350,4524],[920,2200],[250,2600],[850,1500],[300,870]]    // cxh,xxx,hah,hee,hoo
                        @=> int frics[][];
    [[5000,13000],[5500,9700],[1350,4524],[1350,2240]] @=> int plosives[][]; // ppp, ttt, kkk, koo
                        
    fun int setPhoneme(string what)  {  // look through all the names and do accordingly
        0 => int i;
        -1 => int phon;
        quiet(0::samp); // set all gain targets to zero, things below will change if need be
        if ((findPhoneme(what,vowelNames) => phon) > -1) { // first look through vowel names
            formants(vowels[phon][0],vowels[phon][1],vowels[phon][2]);
            1.0 => vGain;
            return phon;
        }
        if ((findPhoneme(what,liquidNames) => phon) > -1)  {  // then liquids
            formants(liquids[phon][0],liquids[phon][1],liquids[phon][2]);
            1.0 => vGain;
            return phon;
        }
        if ((findPhoneme(what,stopNames) => phon) > -1)  { // then names of stops
            formants(stops[phon][0],stops[phon][1],stops[phon][2]);
            1.0 => vGain;
            return phon;
        }
        if ((findPhoneme(what,voicedFricNames) => phon) > -1)  { // then voiced fricatives
            formants(voicedFrics[phon][0],voicedFrics[phon][1],voicedFrics[phon][2]);
            fricatives(voicedFrics[phon][3],voicedFrics[phon][4]);
            0.7 => vGain;   0.2 => cGain;
            return phon;
        }
        if ((findPhoneme(what,fricativeNames) => phon) > -1)  { // then fricatives
            fricatives(frics[phon][0],frics[phon][1]);
            0.2 => cGain;
            return phon;
        }
        if ((findPhoneme(what,plosiveNames) => phon) > -1)  { // then plosives
            fricatives(plosives[phon][0],plosives[phon][1]);
            0.2 => cGain;
            return phon;
        }
        if (phon < 0) {
            <<< "Phoneme: ", what, "not found!!" >>>;
            return -1;
        }
    }

    fun int findPhoneme(string try,string nams[])  {
        -1 => int found;
        for (0 => int i; i < nams.cap(); i++)  {  
            if (nams[i] == try)  i => found;
        }
        return found;
    }

    fun void quiet(dur howLong)  {
        0.0 => voiced => unVoiced => consonant;
        howLong => now;
    }
}

