#[cfg(target_arch = "wasm32")]
pub const TEST_DATA: &[u8] = include_bytes!("brain.bincode");
pub const DEFAULT_SPIRAL: &[u8] = include_bytes!("test_spiral.bincode");