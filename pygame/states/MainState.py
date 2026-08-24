from flexer2d.modules.State import State # needed for all states

from flexer2d.modules.Camera import Camera
from flexer2d.modules.Sprite import Sprite

class MainState(State):
    def __init__(self):
        pass

    def create(self):
        camera = Camera()
        sprite = Sprite('assets/KadeEngineLogo.png',0,0)
        camera.add(sprite)

    def update(self):
        pass

    def draw(self):
        pass

    def destroy(self):
        pass
