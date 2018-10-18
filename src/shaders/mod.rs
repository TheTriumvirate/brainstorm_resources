/// Vertex shader for particles
pub const PARTICLES_VERTEX_SHADER: &[u8] = include_bytes!("particles_vertex.glslv");

/// Fragment shader for particles
pub const PARTICLES_FRAGMENT_SHADER: &[u8] = include_bytes!("particles_fragment.glslf");

pub const TEXT_VERTEX_SHADER: &[u8] = include_bytes!("text.vert");
pub const TEXT_FRAGMENT_SHADER: &[u8] = include_bytes!("text.frag");

pub const OBJ_VERTEX_SHADER: &[u8] = include_bytes!("obj.vert");
pub const OBJ_FRAGMENT_SHADER: &[u8] = include_bytes!("obj.frag");

pub const STREAMLINES_VERTEX_SHADER: &[u8] = include_bytes!("streamlines.vert");
pub const STREAMLINES_FRAGMENT_SHADER: &[u8] = include_bytes!("streamlines.frag");