import pygame
from datetime import datetime

from flexer2d.modules.Camera import Camera
from flexer2d.modules.State import State

class Engine:

    '''
    TODO:
        - add substates
        - add sounds
    '''

    created = False

    def __init__(self):
        if not Engine.created:
            Engine.created = True
        else:
            print("Engine already created")
            return

        pygame.init()
        self.set_window_size()
        self.set_window_name()

        self.state = None

        self.clock = pygame.time.Clock()
        self.delta = 0
        self.fps_limit = 60

        self.background_color = (30, 30, 30)

        self.create = None
        self.update = None
        self.draw = None

        self.active = True

    def set_window_name(self, name:str="Flexer2d"):
        self.name = name
        pygame.display.set_caption(name)

    def set_window_size(self, width:int=1280, height:int=720):
        self.screen = pygame.display.set_mode((width, height))
    
    def switch_state(self, state:State):
        if self.state != None:
            self.state.destroy()
            Camera.cameras.clear()
        
        self.state = state
        self.state.create()

    def __create__(self):
        if self.create != None:
            self.create()
    def __update__(self):
        if self.update != None:
            self.update()

        if self.state != None:
            self.state.update()

        if len(Camera.cameras) > 0:
            for camera in Camera.cameras:
                camera.__update__()
    def __draw__(self):
        if self.draw != None:
            self.draw()
        
        if self.state != None:
            self.state.draw()

        if len(Camera.cameras) > 0:
            for camera in Camera.cameras:
                camera.__draw__(self.screen)

    def run(self):
        self.__create__()

        while self.active:
            start_time = datetime.now()

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    self.active = False

            self.__update__()

            self.screen.fill(self.background_color)
            self.__draw__()
            pygame.display.flip()

            end_time = datetime.now()
            self.delta = (end_time - start_time).total_seconds()

            self.clock.tick(self.fps_limit)
            
        pygame.quit()