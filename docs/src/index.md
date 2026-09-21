# Alidade

<script 
    type="module" 
    src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js">
</script>

<div class="model-container" id="model-container">
    <button id="fullscreen-btn" class="fullscreen-btn" title="Fullscreen">
        ⛶
    </button>

    <model-viewer 
        src="/alidade/alidade-hw/3d/alidade-3D.glb"
        alt="Interactive 3D view of the PCB"
        camera-controls
        environment-image="neutral"
        tone-mapping="agx"
        render-scale="1"
        exposure="0.45"
        shadow-intensity="0.3"
        shadow-softness="1"
        camera-orbit="0deg 60deg auto"
    </model-viewer>
</div>

<script>
  const container = document.getElementById('model-container');
  const button = document.getElementById('fullscreen-btn');

  button.addEventListener('click', async () => {
    if (!document.fullscreenElement) {
      await container.requestFullscreen();
    } else {
      await document.exitFullscreen();
    }
  });

  document.addEventListener('fullscreenchange', () => {
    button.title = document.fullscreenElement
      ? 'Exit fullscreen'
      : 'Fullscreen';
  });
</script>

<style>
  .model-container {
    position: relative;
    width: 100%;
    height: 500px;
  }

  .model-container model-viewer {
    display: block;
    width: 100%;
    height: 100%;

    border: 1px solid var(--md-default-fg-color--lighter);
    background: var(--md-code-bg-color);
    border-radius: 8px;
    overflow: hidden;
  }

  /*
   * Fullscreen
   */
  .model-container:fullscreen {
    position: fixed;
    inset: 0;
    width: 100vw;
    height: 100vh;
    margin: 0;
    padding: 0;
    background: var(--md-code-bg-color);
  }

  .model-container:fullscreen model-viewer {
    width: 100%;
    height: 100%;
    border: none;
    border-radius: 0;
  }

  /*
   * Fullscreen button
   */
  .fullscreen-btn {
    position: absolute;
    top: 12px;
    left: 12px;
    z-index: 10;

    width: 36px;
    height: 36px;
    padding: 0;

    border: none;
    border-radius: 6px;
    background: rgba(40, 40, 40, 0.75);
    color: white;

    font-size: 22px;
    line-height: 36px;
    cursor: pointer;

    backdrop-filter: blur(4px);
  }

  .fullscreen-btn:hover {
    background: rgba(60, 60, 60, 0.9);
  }
</style>
