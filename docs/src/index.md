# Alidade

<script 
    type="module" 
    src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js">
</script>

<model-viewer 
    src="/alidade/alidade-hw/3d/alidade-3D.glb" 
    style="
        width: 100%;
        height: 500px;
        border: 1px solid var(--md-default-fg-color--lighter);
        background: var(--md-code-bg-color);
        border-radius: 8px;
        overflow: hidden;
    "
    alt="Interactive 3D view of the PCB"
    camera-controls
    environment-image="neutral"
    tone-mapping="agx"
    auto-rotate
    rotation-per-second="15deg"
    exposure="0.45"
    shadow-intensity="0.3"
    shadow-softness="1"
    camera-orbit="45deg 60deg auto">
</model-viewer>
