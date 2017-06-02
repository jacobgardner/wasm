use std::time::{SystemTime, Duration};
use std::cmp::Ordering;

fn prime_seive(max_prime: usize) -> Vec<u64> {
    let mut is_prime: Vec<bool> = (0..max_prime)
        .map(|idx| if idx & 1 == 0 { false } else { true })
        .collect();

    let mut prime_list = vec![2];

    for idx in 3..max_prime {
        if is_prime[idx] {
            prime_list.push(idx as u64);
            let mut mult = 2;
            while mult * idx < max_prime {
                is_prime[mult * idx] = false;
                mult += 1;
            }
        }
    }

    prime_list
}

fn duration_to_sec(duration: Duration) -> f64 {
    duration.as_secs() as f64 + (duration.subsec_nanos() as f64 / 1000000000f64)
}

fn main() {

    let iterations = 500;
    let max_prime = 100000;
    let mut total_time: f64 = 0f64;

    let mut times = vec![];

    for _ in 0..iterations {
        let start = SystemTime::now();
        prime_seive(max_prime);

        let duration = duration_to_sec(start.elapsed().unwrap());

        times.push(duration);
        total_time += duration;
    }

    times.sort_by(|a, b| if a < b {Ordering::Less} else {Ordering::Greater} );

    println!("Prime Seive 1000x:");
    println!(" Total Time:   {}s", total_time);
    println!(" Average Time: {}s", total_time / iterations as f64);
    println!(" Median Time: {}s", times[iterations / 2]);

    println!("{:?}", prime_seive(100));

}
