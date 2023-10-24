% add stagePosition
function coordinates_new = convert_coordinates_and_add_stage_position(centerline, stagePosition)
    global pixel2um unit2um
    coordinates_in_the_video = reshape(centerline, 2, 100);
    stagePosition = stagePosition';   
    coordinates_new = pixel2um / 10^3 * coordinates_in_the_video + unit2um / 10^3 * stagePosition;
end