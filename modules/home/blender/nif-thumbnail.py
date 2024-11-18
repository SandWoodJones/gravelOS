import bpy

def delete_hierarchy(obj):
    for child in list(obj.children):
        delete_hierarchy(child)
    bpy.data.objects.remove(obj, do_unlink=True)

def render(o, s):
    import mathutils
    scene = bpy.context.scene

    # positioning camera
    bpy.ops.view3d.camera_to_view_selected()

    cam_dir = scene.camera.matrix_world.to_3x3() @ mathutils.Vector((0.0, 0.0, -1.0))
    dist = (scene.camera.location - bpy.context.view_layer.objects.active.location).length
    if dist < 0.1:
        scene.camera.location -= cam_dir * 0.5

    scene.render.engine = "BLENDER_WORKBENCH"
    scene.render.use_compositing = False

    scene.render.image_settings.file_format = 'PNG'
    scene.render.filepath = o

    scene.render.resolution_x = s
    scene.render.resolution_y = s

    scene.frame_end = 1
    scene.render.film_transparent = True

    print(f"rendering to {o}")
    bpy.ops.render.render(write_still=True)

def main():
    import sys
    import argparse
    import os

    argv = sys.argv
    if "--" not in argv:
        argv = []
    else:
        argv = argv[argv.index("--") + 1:]

    parser = argparse.ArgumentParser()
    parser.add_argument("input_path", type=str, help="path of the input .nif file")
    parser.add_argument("output_path", type=str, help="path of the output .png file")
    parser.add_argument("size_px", type=int, help="size of the .png in pixels")

    args = parser.parse_args(argv)

    if not os.path.isfile(args.input_path):
        print(f"'{args.input_path}' is not a valid file")
        return 1

    # enabling io_scene_mw
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.io_scene_mw")

    # deleting default cube
    bpy.data.objects.get("Cube").select_set(True)
    bpy.ops.object.delete()

    # importing morrowind scene
    bpy.ops.import_scene.mw(filepath=f"{args.input_path}")

    # deleting collisions
    collisions = [ obj for obj in bpy.context.scene.objects if "COL" in obj.name or "Collision" in obj.name ]
    for obj in collisions:
        delete_hierarchy(obj)

    render(args.output_path, args.size_px)

if __name__ == "__main__":
    main()
