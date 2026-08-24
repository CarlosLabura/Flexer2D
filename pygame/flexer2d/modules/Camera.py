import pygame
from flexer2d.modules.Object import Object

class Camera(Object):
    cameras = []

    '''
    TODO:
        - add zoom
        - add scroll factor
        - scroll follow function
    '''

    def __init__(self, x:int=0, y:int=0, width:int=1280, height:int=720):
        super().__init__(x, y, width, height)

        self.objects = []
        self.screen = pygame.Surface((self.width, self.height), pygame.SRCALPHA)

        self.background_color = (30, 30, 30)
        self.backgroud_alpha = 1

        self.scroll_x = 0
        self.scroll_y = 0

        self.zoom = 1

        Camera.cameras.append(self)

    def set_scroll(self,x:int,y:int):
        self.scroll_x = x
        self.scroll_y = y
    def add_scroll(self,x:int=0,y:int=0):
        self.scroll_x += x
        self.scroll_y += y

    def add(self, object:Object):
        if object != None:
            self.objects.append(object)

    def __update__(self):
        super().__update__()

        if not self.active:
            return
        
        if len(self.objects) > 0:
            for object in self.objects:
                object.__update__()


    def __draw__(self, screen:pygame.Surface):
        super().__draw__()

        if not self.visible:
            return

        self.screen.fill((self.background_color[0],self.background_color[1],self.background_color[2],255*self.backgroud_alpha))
        if len(self.objects) > 0:
            for object in self.objects:
                object.__draw__(self)
        screen.blit(self.screen, (self.x, self.y))



    
        
