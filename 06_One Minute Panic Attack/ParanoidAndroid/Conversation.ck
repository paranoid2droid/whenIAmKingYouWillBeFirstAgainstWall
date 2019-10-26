// Humen and DeepThought
// by Zhe Zhang
// I used this speech synthesizer to generate a dialogue
// from the <Hitchhiker's Guide to the Galaxy>
// On the left is the human and on the right is the giant computer
// aka DeepThought
// It works pretty awesome due to the Sci-Fi nature of the synthesizing

// two mouth
FormantVoice paranoid => dac.left;
FormantVoice android => dac.right;

// one big and one small
0.66 => paranoid.headSize;
1.42 => android.headSize;

// keep talkin'
we( paranoid, 360 );
are ( paranoid, 360 );
paranoid.quiet(50::ms);
the ( paranoid, 300 );
ones ( paranoid, 400 );
paranoid.quiet(50::ms);
who ( paranoid, 300 );
will ( paranoid, 300 );
paranoid.quiet(50::ms);
hear ( paranoid, 400 );
paranoid.quiet(600::ms);

the ( paranoid, 200 );
answer ( paranoid, 400);
paranoid.quiet(50::ms);
to ( paranoid, 300 );
the ( paranoid, 200 );
paranoid.quiet(30::ms);
great ( paranoid, 400 );
paranoid.quiet(50::ms);
question ( paranoid, 360 );
paranoid.quiet(600::ms);

of ( paranoid, 300 );
life ( paranoid, 420 );
paranoid.quiet(600::ms);

the ( paranoid, 300 );
universe ( paranoid, 500 );
paranoid.quiet(600::ms);

and ( paranoid, 300 );
everything ( paranoid, 600 );
paranoid.quiet(200::ms);

2::second => now;

good ( android, 130 );
paranoid.quiet(120::ms);
morning ( android, 150 );
android.quiet(1200::ms);

an ( android, 100 );
android.quiet(42::ms);
answer2 ( android, 120);
android.quiet(42::ms);
forr( android, 120 );
android.quiet(42::ms);
you ( android, 120 );
android.quiet(900::ms);
yes ( android, 180 );
Ihave ( android, 150);
android.quiet(800::ms);

the2 ( android, 120 );
answer2 ( android, 130 );
android.quiet(222::ms);
to2 ( android, 100 );
the2 ( android, 80 );
android.quiet(42::ms);
great2 ( android, 150 );
android.quiet(42::ms);
question2 ( android, 130 );
android.quiet(42::ms);

yeeaas ( paranoid, 500, 3 );
paranoid.quiet(20::ms);

of2 ( android, 100 );
life2 ( android, 150 );
android.quiet(600::ms);
the2 ( android, 100);
universe2 ( android, 120 );
android.quiet(900::ms);
and2 ( android, 100);
everything ( android, 100 );
android.quiet(20::ms);

yeeaas ( paranoid, 600, 5 );
paranoid.quiet(20::ms);

is ( android, 100 );
android.quiet(20::ms);

yeeaas ( paranoid, 700, 7);
paranoid.quiet(2000::ms);

fortytwo ( android, 142);
android.quiet(42::ms);

3::second => now;

// the functions used above
fun void we( FormantVoice fmv, float pitch ){
    pitch => fmv.pitchNow;
    fmv.setPhoneme("uuu");
    50::ms => now;
    fmv.setPhoneme("eee");
    200::ms => now;
}

fun void are( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ahh");
    pitch/1.5 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.95 *=> pitch;
        pitch => fmv.pitch;
    }
    200::ms => now;
    fmv.setPhoneme("rrr");
    60::ms => now;
}

fun void the( FormantVoice fmv, float pitch ){
    
    fmv.setPhoneme("ddd");
    40::ms => now;
    pitch => fmv.pitch;
    fmv.setPhoneme("uhh");
    110::ms => now;
}

fun void ones( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("uuu");
    100::ms => now;
    fmv.setPhoneme("nng");    
    pitch/2.0 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    fmv.setPhoneme("sss");
    20::ms => now;
}

fun void who( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("hoo");
    100::ms => now;
    fmv.setPhoneme("ooo");
    300::ms => now;
}

fun void will( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("uuu");
    150::ms => now;
    fmv.setPhoneme("eee");    
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    fmv.setPhoneme("lll");
    60::ms => now;
}

fun void hear( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("hee");
    50::ms => now;
    fmv.setPhoneme("eee");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    fmv.setPhoneme("uhh");
    50::ms => now;
}

fun void answer( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("aah");
    300::ms => now;
    fmv.setPhoneme("nnn");
    50::ms => now;    
    fmv.setPhoneme("sss");
    100::ms => now;
    fmv.setPhoneme("rrr");
    pitch/2 => fmv.pitch;
    150::ms => now;
}

fun void to( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ttt");
    50::ms => now;
    fmv.setPhoneme("ooo");
    200::ms => now;
}

fun void great( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ggg");
    50::ms => now;
    fmv.setPhoneme("rrr");
    100::ms => now;
    fmv.setPhoneme("eee");
    300::ms => now;
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.96 *=> pitch;
        pitch => fmv.pitch;
    }
    fmv.setPhoneme("ttt");
    50::ms => now;
}

fun void question( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("kkk");
    30::ms => now;
    fmv.setPhoneme("ooo");
    80::ms => now;
    fmv.setPhoneme("ehh");
    200::ms => now;    
    fmv.setPhoneme("sss");
    50::ms => now;
    pitch/2 => fmv.pitch;
    fmv.setPhoneme("shh");
    20::ms => now;
    fmv.setPhoneme("uhh");
    200::ms => now;
    fmv.setPhoneme("nnn");
    150::ms => now;    
}

fun void of( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("uhh");
    100::ms => now;
    fmv.setPhoneme("fff");
    30::ms => now;
}

fun void life( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("lll");
    50::ms => now;
    fmv.setPhoneme("aah");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.99 *=> pitch;
        pitch => fmv.pitch;
    }
    20::ms => now;
    fmv.setPhoneme("fff");
    30::ms => now;
}

fun void universe( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("eee");
    100::ms => now;
    fmv.setPhoneme("uuu");
    100::ms => now;
    pitch/1.8 => fmv.pitch;
    fmv.setPhoneme("nnn");
    50::ms => now;    
    fmv.setPhoneme("eee");
    50::ms => now;  
    fmv.setPhoneme("vvv");
    50::ms => now;  
    fmv.setPhoneme("uhh");
    50::ms => now;  
    fmv.setPhoneme("rrr");
    pitch/1.5 => pitch;
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.99 *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
    fmv.setPhoneme("sss");
    30::ms => now;
}

fun void and( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ahh");
    150::ms => now;
    fmv.setPhoneme("nnn");
    50::ms => now;
    fmv.setPhoneme("ddd");
    50::ms => now;    
}

fun void everything( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ehh");
    500::ms => now;
    fmv.setPhoneme("vvv");
    50::ms => now;
    fmv.setPhoneme("rrr");
    50::ms => now;
    fmv.setPhoneme("eee");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.99 *=> pitch;
        pitch => fmv.pitch;
    }
    20::ms => now;
    pitch/1.5 => fmv.pitch;
    fmv.setPhoneme("thh");
    30::ms => now;
    fmv.setPhoneme("eee");
    200::ms => now;    
    fmv.setPhoneme("nng");
    pitch/2 => targ;
    while( pitch > targ ){
        10::ms => now;
        0.99 *=> pitch;
        pitch => fmv.pitch;
    }
    60::ms => now;  
}

fun void good( FormantVoice fmv, float pitch ){
    pitch => fmv.pitchNow;
    fmv.setPhoneme("ggg");
    200::ms => now;
    fmv.setPhoneme("ooo");
    pitch/1.5 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.993 *=> pitch;
        pitch => fmv.pitch;
    }
    200::ms => now;
    fmv.setPhoneme("ddd");
    300::ms => now;
}

fun void morning( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("mmm");
    100::ms => now;
    fmv.setPhoneme("ohh");
    300::ms => now;
    fmv.setPhoneme("rrr");
    100::ms => now;
    pitch/2 => fmv.pitch;
    fmv.setPhoneme("nnn");
    100::ms => now;
    fmv.setPhoneme("eee");
    100::ms => now;    
    fmv.setPhoneme("nng");
    pitch/2 => pitch;
    pitch/3 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    60::ms => now;  
}

fun void an( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ahh");
    250::ms => now;
    fmv.setPhoneme("nnn");
    100::ms => now; 
}

fun void answer2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("aah");
    360::ms => now;
    fmv.setPhoneme("nnn");
    120::ms => now;    
    fmv.setPhoneme("sss");
    100::ms => now;
    fmv.setPhoneme("rrr");
    pitch/2 => fmv.pitch;
    220::ms => now;
}

fun void forr( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("fff");
    120::ms => now;       
    fmv.setPhoneme("ohh");
    200::ms => now;
    fmv.setPhoneme("rrr");
    100::ms => now;
}

fun void you( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("eee");
    200::ms => now;
    fmv.setPhoneme("ooo");
    pitch*1.5 => float targ;
    while( pitch < targ ){
        10::ms => now;
        1.007 *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
}

fun void yes( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("eee");
    100::ms => now;
    fmv.setPhoneme("ehh");
    pitch/1.5 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.992 *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
    fmv.setPhoneme("sss");
    200::ms => now;
}

fun void Ihave( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("aah");
    200::ms => now;
    fmv.setPhoneme("eee");
    100::ms => now;
    fmv.setPhoneme("hah");
    100::ms => now;
    fmv.setPhoneme("aah");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.992 *=> pitch;
        pitch => fmv.pitch;
    }
    fmv.setPhoneme("eee");
    100::ms => now;
    fmv.setPhoneme("vvv");
    50::ms => now;
}

fun void the2( FormantVoice fmv, float pitch ){
    
    fmv.setPhoneme("ddd");
    50::ms => now;
    pitch => fmv.pitch;
    fmv.setPhoneme("ehh");
    200::ms => now;
}

fun void to2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ttt");
    100::ms => now;
    fmv.setPhoneme("ooo");
    300::ms => now;
}

fun void great2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ggg");
    100::ms => now;
    fmv.setPhoneme("rrr");
    200::ms => now;
    fmv.setPhoneme("eee");
    400::ms => now;
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.95 *=> pitch;
        pitch => fmv.pitch;
    }
    fmv.setPhoneme("ttt");
    100::ms => now;
}

fun void question2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("kkk");
    60::ms => now;
    fmv.setPhoneme("ooo");
    120::ms => now;
    fmv.setPhoneme("ahh");
    200::ms => now;    
    fmv.setPhoneme("sss");
    100::ms => now;
    pitch/2 => fmv.pitch;
    fmv.setPhoneme("shh");
    50::ms => now;
    fmv.setPhoneme("uhh");
    200::ms => now;
    fmv.setPhoneme("nnn");
    150::ms => now;    
}

fun void yeeaas( FormantVoice fmv, float pitch, float sustain ){
    pitch => fmv.pitch;
    fmv.setPhoneme("eee");
    (sustain/5)::second => now;
    fmv.setPhoneme("ehh");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.99+(sustain*0.001) *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
    fmv.setPhoneme("sss");
    60::ms => now;
}

fun void of2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("uhh");
    200::ms => now;
    fmv.setPhoneme("fff");
    50::ms => now;
}

fun void life2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("lll");
    100::ms => now;
    fmv.setPhoneme("aah");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
    fmv.setPhoneme("fff");
    50::ms => now;
}

fun void universe2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("eee");
    200::ms => now;
    fmv.setPhoneme("uuu");
    200::ms => now;
    pitch/1.8 => fmv.pitch;
    fmv.setPhoneme("nnn");
    100::ms => now;    
    fmv.setPhoneme("eee");
    100::ms => now;  
    fmv.setPhoneme("vvv");
    100::ms => now;  
    fmv.setPhoneme("uhh");
    100::ms => now;  
    fmv.setPhoneme("rrr");
    pitch/1.5 => pitch;
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
    fmv.setPhoneme("sss");
    50::ms => now;
}

fun void and2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ahh");
    150::ms => now;
    fmv.setPhoneme("nnn");
    100::ms => now;
    fmv.setPhoneme("ddd");
    100::ms => now;    
}

fun void everything2( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("ehh");
    600::ms => now;
    fmv.setPhoneme("vvv");
    100::ms => now;
    fmv.setPhoneme("rrr");
    100::ms => now;
    fmv.setPhoneme("eee");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    50::ms => now;
    pitch/1.5 => fmv.pitch;
    fmv.setPhoneme("thh");
    50::ms => now;
    fmv.setPhoneme("eee");
    200::ms => now;    
    fmv.setPhoneme("nng");
    pitch/2 => targ;
    while( pitch > targ ){
        10::ms => now;
        0.98 *=> pitch;
        pitch => fmv.pitch;
    }
    60::ms => now;  
}

fun void is( FormantVoice fmv, float pitch ){
    pitch => fmv.pitch;
    fmv.setPhoneme("eee");
    500::ms => now;
    fmv.setPhoneme("sss");
    60::ms => now;
}

fun void fortytwo ( FormantVoice fmv, float pitch ){
    android => NRev r => dac;
    .2 => r.gain;
    .9 => r.mix;
    pitch => fmv.pitch;
    fmv.setPhoneme("fff");
    66::ms => now;
    fmv.setPhoneme("ohh");
    442::ms => now;
    fmv.setPhoneme("rrr");
    142::ms => now;
    fmv.setPhoneme("ttt");
    42::ms => now;
    fmv.setPhoneme("eee");
    442::ms => now;
    fmv.setPhoneme("ttt");
    42::ms => now;
    fmv.setPhoneme("ooo");
    pitch/2 => float targ;
    while( pitch > targ ){
        10::ms => now;
        .998 *=> pitch;
        pitch => fmv.pitch;
    }
    222::ms => now;
}