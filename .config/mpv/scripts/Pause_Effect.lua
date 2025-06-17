-- Flags to track if effects are applied
local grayscale_applied = false
local zoom_applied = false

-- Function to apply grayscale and zoom effects
function apply_effects()
    if not grayscale_applied and not zoom_applied then
        -- Apply grayscale and zoom in one go (frame-by-frame zoom)
        mp.commandv("set", "vf", "eq=saturation=0,crop=iw/1.1:ih/1.1:iw*0.05:ih*0.05,scale=iw*1.1:ih*1.1")
        mp.osd_message("Pause")
        grayscale_applied = true
        zoom_applied = true
    end
end

-- Function to reset grayscale and zoom effects immediately
function reset_effects()
    if grayscale_applied or zoom_applied then
        -- Immediately reset zoom and reset grayscale to normal color
        mp.commandv("set", "vf", "crop=iw:ih:0:0,scale=iw:ih")  -- Reset zoom to normal size
        mp.commandv("set", "vf", "eq=saturation=1")  -- Reset color to normal

        -- Reset flags after effects are reset
        grayscale_applied = false
        zoom_applied = false
    end
end

-- Monitor the video state (paused or playing)
mp.observe_property("pause", "bool", function(name, value)
    if value then  -- If paused
        apply_effects()  -- Apply grayscale + zoom immediately
    else  -- If playing
        reset_effects()  -- Reset effects immediately
    end
end)

-- Ensure the filter is cleared when a new video is loaded
mp.register_event("file-loaded", function()
    reset_effects()  -- Reset effects when a new file is loaded
end)
