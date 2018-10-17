#[cfg(target_arch = "wasm32")]
pub const TEST_DATA: &[u8] = include_bytes!("brain.bincode");