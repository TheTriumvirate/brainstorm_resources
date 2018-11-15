/// Vertex shader for particles
pub const PARTICLES_VERTEX_SHADER: &[u8] = include_bytes!("particles.vert");

/// Fragment shader for particles
pub const PARTICLES_FRAGMENT_SHADER: &[u8] = include_bytes!("particles.frag");

pub const TEXT_VERTEX_SHADER: &[u8] = include_bytes!("text.vert");
pub const TEXT_FRAGMENT_SHADER: &[u8] = include_bytes!("text.frag");

pub const OBJ_VERTEX_SHADER: &[u8] = include_bytes!("obj.vert");
pub const OBJ_FRAGMENT_SHADER: &[u8] = include_bytes!("obj.frag");

pub const STREAMLINES_VERTEX_SHADER: &[u8] = include_bytes!("streamlines.vert");
pub const STREAMLINES_FRAGMENT_SHADER: &[u8] = include_bytes!("streamlines.frag");

pub const GPU_PARTICLES_VERTEX_SHADER: &[u8] = include_bytes!("gpu_particles.vert");
pub const GPU_PARTICLES_FRAGMENT_SHADER: &[u8] = include_bytes!("gpu_particles.frag");

pub const GPU_PARTICLES_UPDATE_VERTEX_SHADER: &[u8] = include_bytes!("gpu_updater.vert");
pub const GPU_PARTICLES_UPDATE_FRAGMENT_SHADER: &[u8] = include_bytes!("gpu_updater.frag");

pub const MAP_VERTEX_SHADER: &[u8] = include_bytes!("map.vert");
pub const MAP_FRAGMENT_SHADER: &[u8] = include_bytes!("map.frag");
