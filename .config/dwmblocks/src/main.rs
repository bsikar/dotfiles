use std::ffi::CString;
use std::os::raw::c_char;
use std::process::Command;
use std::ptr::null;
use std::thread::sleep;
use std::time::Duration;
use sysinfo::{ProcessorExt, SystemExt};
use x11::xlib::{False, XDefaultRootWindow, XOpenDisplay, XStoreName, XSync};

fn main() {
    unsafe {
        let display = XOpenDisplay(null());

        loop {
            XStoreName(
                display,
                XDefaultRootWindow(display),
                get_status().as_ptr() as *mut c_char,
            );
            XSync(display, False);
            sleep(Duration::from_millis(50));
        }
    }
}

fn get_status() -> CString {
    let sys = sysinfo::System::new_all();
    let ram = (sys.used_memory() as f32 / sys.total_memory() as f32) * 100.;
    let swap = (sys.used_swap() as f32 / sys.total_swap() as f32) * 100.;
    let cpu = sys.global_processor_info().cpu_usage();
    let vol = String::from_utf8(
        Command::new("/bin/sh")
            .arg("-c")
            .arg("amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'")
            .output()
            .expect("failed to get vol")
            .stdout,
    )
    .expect("failed to get utf-8 from vol output");
    let date = chrono::Local::now().format("%a %b %e %r").to_string();

    CString::new(format!(
        "ram: {:.2}% swap: {:.2}% cpu: {:.2}% vol: {} {}",
        ram, swap, cpu, vol, date
    ))
    .unwrap()
}
