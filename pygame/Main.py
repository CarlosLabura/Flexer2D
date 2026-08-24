import flexer2d.Flexer2d as Flexer2d

'''
    from states.AltState import AltState
    Flexer2d.game.switch_state(AltState())
'''

from states.MainState import MainState
Flexer2d.game.switch_state(MainState())
Flexer2d.game.run()