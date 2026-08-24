class Object:

    '''
    TODO:
        - add debug hitbox viewer
    '''

    def __init__(self, x:int=0, y:int=0, width:int=1, height:int=1):
        self.set_position(x,y)
        self.set_size(width,height)
        self.set_scale(1, 1)

        self.active = True
        self.visible = True
        self.debug = False
                
        self.update = None
        self.draw = None

    def set_position(self, x:int, y:int):
        self.x = x
        self.y = y
    def add_position(self, x:int=0, y:int=0):
        self.x += x
        self.y += y

    def set_scale(self, x:int=1, y:int=1):
        self.scale_x = x
        self.scale_y = y
    def add_scale(self, x:int=0, y:int=0):
        self.scale_x += x
        self.scale_y += y

    def set_size(self, width:int=1, height:int=1):
        self.width = width
        self.height = height

    def __draw__(self):
        if not self.visible:
            return
        
        if self.draw != None:
            self.draw()
        
    def __update__(self):
        if not self.active:
            return
        
        if self.update != None:
            self.update()    