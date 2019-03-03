import plotly.plotly as py
from plotly.graph_objs import *
py.sign_in('sk1234', 'uBB82u0cTNHBQAUZJD8V')
cause1 = Barpolar(
  r=[477,508,802,382,483,189,128,178,91,42,24,15],
  text=['April 1855', 'May 1855', 'June 1855', 'July 1855', 'August 1855', 'September 1855', 'October 1855', 'November 1855', 'December 1855', 'January 1856', 'February 1856',
        'March 1856'],
  name='Zymotic diseases',
  theta=['April 1855', 'May 1855', 'June 1855', 'July 1855', 'August 1855', 'September 1855', 'October 1855', 'November 1855', 'December 1855', 'January 1856', 'February 1856',
        'March 1856'],
  marker=dict(
    color='rgb(142, 206, 209)',
    opacity=1
  ),

)
cause2 = Barpolar(
  r=[48,49,209,134,164,276,53,33,18,2,0,0],
  text=['April 1855', 'May 1855', 'June 1855', 'July 1855', 'August 1855', 'September 1855', 'October 1855', 'November 1855', 'December 1855', 'January 1856', 'February 1856',
        'March 1856'],
  name='Wounds & injuries',
  theta=['April 1855', 'May 1855', 'June 1855', 'July 1855', 'August 1855', 'September 1855', 'October 1855', 'November 1855', 'December 1855', 'January 1856', 'February 1856',
        'March 1856'],
  marker=dict(
    color='rgb(252,112,147)',
    opacity=1
  ),

)
cause3 = Barpolar(
  r=[57,37,31,33,25,20,18,32,28,48,19,35],
  text=['April 1855', 'May 1855', 'June 1855', 'July 1855', 'August 1855', 'September 1855', 'October 1855', 'November 1855', 'December 1855', 'January 1856', 'February 1856',
        'March 1856'],
  theta=['April 1855', 'May 1855', 'June 1855', 'July 1855', 'August 1855', 'September 1855', 'October 1855', 'November 1855', 'December 1855', 'January 1856', 'February 1856',
        'March 1856'],
  name='All other causes',
  marker=dict(
    color='rgb(50,50,50)',
    opacity=1,

  )
)

data = [cause3, cause2, cause1]
layout = Layout(
  title='Diagram of the causes of mortality in the Army in the East.'
        '<br><b> April 1855-March 1856</b>',

  font=dict(
    size=16
  ),
margin= {
    "r": 78,
    "t": 78,
    "b": 78,
    "l": 78,
    "pad": 78
  },
  orientation=150,
  height=1000,
width=1000,
  legend=dict(traceorder='normal',
    font=dict(
      size=14,
      color='rgb(102,102,102)',
      family='Raleway, sans-serif'
    )
  ),
  polar=dict(
    barmode='stack',
    bgcolor='rgb(255, 255, 255)',
    bargap=0,
    radialaxis=dict(
    angle= 70,
    categoryarray=[0, 777.0149999999969],
      ticksuffix='%',
      showgrid=True,
      showline=False,
      showticklabels=False,
      ticks=''
    ),
    angularaxis=dict(
   #categoryarray=[1.9800000000000009, 8.240000000000004],
        showline=False,
       showticklabels=True,
        tickfont=dict(size=12),
        ticks='',
        direction='clockwise'
    ),
  )
)
fig = Figure(data=data, layout=layout)
plot_url = py.plot(fig)