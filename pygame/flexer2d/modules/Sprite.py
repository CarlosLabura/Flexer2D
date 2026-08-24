import pygame
from flexer2d.modules.Object import Object

class Sprite(Object):

    '''
    TODO:
        - add scale
        - add alpha
        - add rotation
    '''

    def __init__(self, image:str, x:int, y:int):
        super().__init__(x, y, 1, 1)

        self.alpha = 1
        self.angle = 0

        self.set_image(image)
    
    def set_image(self, image:str):
        if image != None and image != '':
            self.surface = pygame.image.load(image)
        else:
            self.surface = None

    def __draw__(self, camera):
        super().__draw__()
        if not self.visible:
            return
        
        if self.visible and self.surface != None:
            camera.screen.blit(self.surface, (self.x - camera.scroll_x, self.y - camera.scroll_y))

    
        
