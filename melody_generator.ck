SinOsc s;
160. => float bpm;
(1/bpm)::minute => dur beat;

class Melody {
    float pitches[];
    dur durations[];
    int length;
    ADSR env;

    fun void playNote(float pitch, dur duration) {
        pitch => s.freq;
        duration => now;
    }

    fun void playMelody() {
        s => env => dac;
        for (0 => int i; i < length; i++) {
            env.set(0.1::durations[i],0.1::durations[i],0.15,0.3::durations[i]);
            env.keyOn();
            playNote(pitches[i],durations[i]);
            env.keyOff();
        }
    }
}

Melody test;
[349.23,349.23,523.25,523.25,587.33,587.33,523.25] @=> test.pitches;
[1::beat,1::beat,1::beat,1::beat,1::beat,1::beat,2::beat] @=> test.durations;
7 => test.length;

test.playMelody();