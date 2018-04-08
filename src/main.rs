use std::net::{TcpStream};
#[macro_use]
extern crate clap;
use clap::App;

fn main() {
    let yaml = load_yaml!("cli.yml");
    let matches = App::from_yaml(yaml).get_matches();

    let ip = matches.value_of("ip").unwrap();

    let ports = matches.value_of("ports").unwrap().split(",");
    let port_vec = ports.collect::<Vec<&str>>();

    let ip_and_ports = port_vec.iter()
        .map(|&a| format!("{}:{}", ip, a))
        .collect::<Vec<_>>();

    for addr in ip_and_ports.iter() {
        if let Ok(_stream) = TcpStream::connect(addr) {
            println!("Connected to the server!");
        } else {
            println!("Knock...");
        }
    }
}
