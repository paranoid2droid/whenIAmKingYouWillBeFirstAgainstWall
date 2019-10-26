// SCALE.ck

public class SCALE{
    
    // store the MIDI notes in scale
    static int note1, note2, note3, note4, note5, note6, note7, note8;
    int tonic;
    
    // function for setting the tonic w/ its name
    fun void setTonic( string doh ){
        if ( doh == "B#" ||doh == "C" ) 60 => tonic;
        else if ( doh == "C#" || doh == "Db") 61 => tonic;
        else if ( doh == "D" ) 62 => tonic;
        else if ( doh == "D#" || doh == "Eb" ) 63 => tonic;
        else if ( doh == "E" || doh == "Fb" ) 64 => tonic;
        else if ( doh == "E#" || doh == "F" ) 65 => tonic;
        else if ( doh == "F#" || doh == "Gb" ) 66 => tonic;
        else if ( doh == "G" ) 67 => tonic;
        else if ( doh == "G#" || doh == "Ab" ) 68 => tonic;
        else if ( doh == "A" ) 69 => tonic;
        else if ( doh == "A#" || doh == "Bb" ) 70 => tonic;
        else if ( doh == "B" || doh == "Cb") 71 => tonic;
        else <<< "Invalid Value!!!" >>>;
        <<< "Tonic: ",doh >>>;
    }
    
    // setting the MIDI numbers in scale according to the tonic
    fun void setScale( string select ){
        if( select == "Ionian" ){
            tonic => note1;
            note1 + 2 => note2;
            note2 + 2 => note3;
            note3 + 1 => note4;
            note4 + 2 => note5;
            note5 + 2 => note6;
            note6 + 2 => note7;
            note7 + 1 => note8;
        }
        else if( select == "Dorian" ){
            tonic => note1;
            note1 + 2 => note2;
            note2 + 1 => note3;
            note3 + 2 => note4;
            note4 + 2 => note5;
            note5 + 2 => note6;
            note6 + 1 => note7;
            note7 + 2 => note8;
        }
        else if( select == "Phrygian" ){
            tonic => note1;
            note1 + 1 => note2;
            note2 + 2 => note3;
            note3 + 2 => note4;
            note4 + 2 => note5;
            note5 + 1 => note6;
            note6 + 2 => note7;
            note7 + 2 => note8;
        }    
        else if( select == "Lydian" ){
            tonic => note1;
            note1 + 2 => note2;
            note2 + 2 => note3;
            note3 + 2 => note4;
            note4 + 1 => note5;
            note5 + 2 => note6;
            note6 + 2 => note7;
            note7 + 1 => note8;
        }  
        else if( select == "Mixolydian" ){
            tonic => note1;
            note1 + 2 => note2;
            note2 + 2 => note3;
            note3 + 1 => note4;
            note4 + 2 => note5;
            note5 + 2 => note6;
            note6 + 1 => note7;
            note7 + 2 => note8;
        }  
        else if( select == "Aeolian" ){
            tonic => note1;
            note1 + 2 => note2;
            note2 + 1 => note3;
            note3 + 2 => note4;
            note4 + 2 => note5;
            note5 + 1 => note6;
            note6 + 2 => note7;
            note7 + 2 => note8;
        }  
        else if( select == "Locrian" ){
            tonic => note1;
            note1 + 1 => note2;
            note2 + 2 => note3;
            note3 + 2 => note4;
            note4 + 1 => note5;
            note5 + 2 => note6;
            note6 + 2 => note7;
            note7 + 2 => note8;
        }  
        else <<< "Invalid Value!!!" >>>;
        <<< "Sacle: ", select >>>;

    }
    
    // change the octave used
    fun void setOctave( int octave ){
        if( octave > -3 && octave < 3 ){
            octave*12 +=> note1;
            octave*12 +=> note2;
            octave*12 +=> note3;
            octave*12 +=> note4;
            octave*12 +=> note5;
            octave*12 +=> note6;
            octave*12 +=> note7;
            octave*12 +=> note8;
        }
        else <<< "Too much!!!" >>>;
        <<< "Octave:", octave >>>;
    }
}

