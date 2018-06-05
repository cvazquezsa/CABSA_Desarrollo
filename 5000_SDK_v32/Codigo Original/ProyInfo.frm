[Forma]
Clave=ProyInfo
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Información del Proyecto
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=172
PosicionInicialArriba=146
PosicionInicialAlturaCliente=397
PosicionInicialAncho=936

ListaCarpetas=(Lista)
CarpetaPrincipal=Proyecto
PosicionCol1=443
Comentarios=Info.Proyecto

Menus=S
PosicionSec1=304
EsConsultaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spProyInfoPresupuesto :nEstacion, :TEmpresa, :TProyecto<T>, EstacionTrabajo, Empresa, Info.Proyecto)
MenuPrincipal=&Ver
[Proyecto]
Estilo=Ficha
Pestana=S
Clave=Proyecto
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Proy
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Filtros=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)



FiltroGeneral=Proy.Proyecto = {Comillas(Info.Proyecto)}
[Proyecto.Proy.Descripcion]
Carpeta=Proyecto
Clave=Proy.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Proyecto.Proy.Categoria]
Carpeta=Proyecto
Clave=Proy.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

EspacioPrevio=S
[Proyecto.Proy.Estatus]
Carpeta=Proyecto
Clave=Proy.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Proyecto.Proy.FechaInicio]
Carpeta=Proyecto
Clave=Proy.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

Tamano=20
EspacioPrevio=S
[Proyecto.Proy.FechaFin]
Carpeta=Proyecto
Clave=Proy.FechaFin
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata

Tamano=20























[Proyecto.Proy.Direccion]
Carpeta=Proyecto
Clave=Proy.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Plata

[Proyecto.Proy.Colonia]
Carpeta=Proyecto
Clave=Proy.Colonia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata



[Proyecto.Proy.CodigoPostal]
Carpeta=Proyecto
Clave=Proy.CodigoPostal
Editar=S
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata

Pegado=S
[Proyecto.Proy.Estado]
Carpeta=Proyecto
Clave=Proy.Estado
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata


[Proyecto.Proy.Pais]
Carpeta=Proyecto
Clave=Proy.Pais
Editar=S
3D=S
Pegado=S
Tamano=9
ColorFondo=Plata


[Presupuesto]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Presupuesto
Clave=Presupuesto
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyInfoPresupuesto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S




ListaEnCaptura=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
[Presupuesto.Columnas]
Mov=124
MovID=64
Concepto=115
Cantidad=64
Precio=64
ImporteLinea=64

0=54
1=56
2=76
3=62
4=-2
5=-2




6=76

Ejercido=64
FechaEmision=94
Pendiente=64


Ejercicio=43
Periodo=40
MovMoneda=44
Presupuesto=74
GastoPendiente=65
GastoEjercido=84

Disponible=64







7=-2
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
Visible=S
ConCondicion=S

EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
AntesExpresiones=Asigna(Info.Rama, <T>PROY<T>)<BR>Asigna(Info.Cuenta, Proy:Proy.Proyecto)<BR>Asigna(Info.Descripcion,Proy:Proy.Descripcion)
RefrescarDespues=S
[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Ver
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
















































Expresion=VerDocumentacion(<T>PROY<T>,Proy:Proy.Proyecto, <T>Documentación - <T>+Proy:Proy.Descripcion)
EjecucionCondicion=ConDatos(Proy:Proy.Proyecto)
[Gastos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gastos
Clave=Gastos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GastoT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

ListaEnCaptura=(Lista)


MenuLocal=S
ListaAcciones=(Lista)
FiltroPredefinido2=
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasNormal=S
FiltroMonedasCampo=GastoT.Moneda
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroFechasCampo=GastoT.FechaEmision
FiltroFechasDefault=Esta Semana

IconosNombre=GastoT:GastoT.Mov + <T> <T> + GastoT:GastoT.MovID
FiltroGeneral=GastoT.Empresa = {Comillas(Empresa)}<BR>AND GastoT.Proyecto = {Comillas(Info.Proyecto)}<BR>AND MovTipo.Clave in (<T>GAS.C<T>, <T>GAS.CB<T>, <T>GAS.CCH<T>, <T>GAS.G<T>, <T>GAS.GTC<T>)<BR>AND GastoT.Estatus in (<T>CONCLUIDO<T>)
[Gastos.Columnas]
0=155

1=-2
2=-2
3=121
4=81
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2
19=-2
20=-2
21=-2
22=-2
23=-2
24=-2
25=-2
26=-2
27=-2
28=-2
29=-2
30=-2
31=-2
32=-2
33=-2
34=-2
35=-2
36=-2
37=-2
38=-2
39=-2
40=-2
41=-2
42=-2
43=-2
44=-2
45=-2
46=-2
47=-2
48=-2
49=-2
50=-2
51=-2
52=-2
53=-2
54=-2
55=-2
56=-2
57=-2
58=-2
59=-2
60=-2
61=-2
62=-2
63=-2
64=-2
65=-2
66=-2
67=-2
68=-2
69=-2
70=-2
71=-2
72=-2
73=-2
74=-2
75=-2
76=-2
77=-2
78=-2
79=-2
80=-2
81=-2
82=-2
83=-2
84=-2
85=-2
86=-2
87=-2
88=-2
89=-2
90=-2
91=-2
92=-2
93=-2
94=-2
95=-2
96=-2
97=-2
98=-2
99=-2
100=-2
101=-2
102=-2
103=-2
104=-2
105=-2
106=-2
107=-2
108=-2
109=-2
110=-2
111=-2
112=-2
113=-2
114=-2
115=-2
116=-2
117=-2
118=-2
119=-2
120=-2
121=-2
122=-2
123=-2
124=-2
125=-2
126=-2
127=-2
128=-2
129=-2
130=-2
131=-2
132=-2
133=-2
134=-2
135=-2
136=-2
137=-2
138=-2
139=-2
140=-2
141=-2
142=-2
143=-2
144=-2
145=-2
146=-2
147=-2
148=-2
149=-2
150=-2
151=-2
152=-2
153=-2
154=-2
155=-2
156=-2
157=-2
158=-2
159=-2
160=-2
161=-2
162=-2
163=-2
164=-2
165=-2
166=-2

[Gastos.GastoT.FechaEmision]
Carpeta=Gastos
Clave=GastoT.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.GastoT.Proyecto]
Carpeta=Gastos
Clave=GastoT.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.GastoT.Concepto]
Carpeta=Gastos
Clave=GastoT.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Gastos.GastoT.Importe]
Carpeta=Gastos
Clave=GastoT.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
















Totalizador=1
[CostosIncluidos.AsisteD.Personal]
Carpeta=CostosIncluidos
Clave=AsisteD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[CostosIncluidos.AsisteD.Recurso]
Carpeta=CostosIncluidos
Clave=AsisteD.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[CostosIncluidos.AsisteD.HoraD]
Carpeta=CostosIncluidos
Clave=AsisteD.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[CostosIncluidos.AsisteD.HoraA]
Carpeta=CostosIncluidos
Clave=AsisteD.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[CostosIncluidos.AsisteD.Costo]
Carpeta=CostosIncluidos
Clave=AsisteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[CostosIncluidos.Columnas]
0=-2
1=109
2=-2
3=-2
4=-2



5=-2







6=-2
[Ventas]
Estilo=Iconos
Clave=Ventas
Filtros=S
MenuLocal=S
ListaAcciones=(Lista)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=VentaNeta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Ventas Netas
Pestana=S




BusquedaRapidaControles=S
ListaEnCaptura=(Lista)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasCampo=FechaEmision
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroMonedasCampo=Moneda
FiltroFechasNombre=&Fecha
IconosNombre=VentaNeta:Mov + <T> <T> + VentaNeta:MovID
FiltroGeneral=v.Proyecto = {Comillas(Info.Proyecto)}<BR>AND Empresa = {Comillas(Empresa)}
[Ventas.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2














5=-2
6=72
[CostosIncluidos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Costos Incluidos
Clave=CostosIncluidos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

Vista=AsisteT


Filtros=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General






ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
IconosSubTitulo=<T>Movimiento<T>
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroFechasCampo=Asiste.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroMonedasCampo=Asiste.Moneda
IconosNombre=AsisteT:Asiste.Mov + <T> <T> + AsisteT:Asiste.MovID
FiltroGeneral=Asiste.Empresa = {Comillas(Empresa)}<BR>AND AsisteD.Proyecto = {Comillas(Info.Proyecto)}<BR>AND MovTipo.Clave in (<T>ASIS.RA<T>)<BR>AND Asiste.Estatus in (<T>CONCLUIDO<T>)<BR>AND ISNULL(AsisteD.Extra,0) = 0
[CostosNoIncluidos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Costos Fuera del Alcance
Clave=CostosNoIncluidos
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

Vista=AsisteT
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha






ListaEnCaptura=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
IconosSubTitulo=<T>Movimiento<T>
FiltroFechas=S
FiltroFechasCampo=Asiste.FechaEmision
FiltroMonedasCampo=Asiste.Moneda
FiltroFechasDefault=Esta Semana
IconosNombre=AsisteT:Asiste.Mov + <T> <T> + AsisteT:Asiste.MovID
FiltroGeneral=Asiste.Empresa = {Comillas(Empresa)}<BR>AND AsisteD.Proyecto = {Comillas(Info.Proyecto)}<BR>AND MovTipo.Clave in (<T>ASIS.RA<T>)<BR>AND Asiste.Estatus in (<T>CONCLUIDO<T>)<BR>AND ISNULL(AsisteD.Extra,0) = 1
[OtrosIngresos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Ingresos
Clave=OtrosIngresos
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
ListaAcciones=(Lista)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GastoT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S



ListaEnCaptura=(Lista)
IconosSubTitulo=<T>Movimiento<T>
FiltroFechas=S
FiltroMonedas=S
FiltroFechasCampo=GastoT.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroMonedasCampo=GastoT.Moneda
IconosNombre=GastoT:GastoT.Mov + <T> <T> + GastoT:GastoT.MovID
FiltroGeneral=GastoT.Empresa = {Comillas(Empresa)}<BR>AND GastoT.Proyecto = {Comillas(Info.Proyecto)}<BR>AND MovTipo.Clave in (<T>GAS.OI<T>)<BR>AND GastoT.Estatus in (<T>CONCLUIDO<T>)
[Gestion]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gestión
Clave=Gestion
Filtros=S
MenuLocal=S
ListaAcciones=(Lista)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GestionA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Gestion.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=GestionA:Gestion.Mov + <T> <T> + GestionA:Gestion.MovID
FiltroGeneral=Gestion.Empresa = <T>{Empresa}<T><BR>AND Gestion.Estatus not in (<T>CANCELADO<T>, <T>SINAFECTAR<T>, <T>BORRADOR<T>)<BR>AND Gestion.Proyecto = <T>{Info.Proyecto}<T>
[Gestion.Gestion.Mov]
Carpeta=Gestion
Clave=Gestion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Gestion.Gestion.MovID]
Carpeta=Gestion
Clave=Gestion.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gestion.Gestion.FechaEmision]
Carpeta=Gestion
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro



[Gestion.Columnas]
0=-2
1=-2
2=-2
3=-2


Mov=124
MovID=64
FechaEmision=94


[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
Visible=S
















Menu=&Ver
Antes=S
UsaTeclaRapida=S
TeclaRapida=F11
AntesExpresiones=Asigna(Info.Rama,<T>PROY<T>)<BR>Asigna(Info.Cuenta, Proy:Proy.Proyecto)<BR>Asigna(Info.Descripcion, Proy:Proy.Descripcion)


[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Visible=S



UsaTeclaRapida=S
TeclaRapida=Ctrl+T
EsDefault=S
EspacioPrevio=S


Menu=&Ver






Antes=S
AntesExpresiones=Asigna(Info.PuedeEditar, Falso)<BR>Asigna(Info.Nombre, Proy:Proy.Descripcion)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Proy:Proy.Proyecto)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)


















[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
Menu=&Ver
EsDefault=S
NombreDesplegar=Evaluaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacionInfo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Proy:Proy.Proyecto)<BR>Asigna(Info.Nombre, Proy:Proy.Descripcion)<BR>Asigna(Info.Aplica, <T>Proyectos<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S













[(Carpeta Totalizadores).Presupuesto]
Carpeta=(Carpeta Totalizadores)
Clave=Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro








[CostosNoIncluidos.Asiste.Mov]
Carpeta=CostosNoIncluidos
Clave=Asiste.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CostosNoIncluidos.Asiste.MovID]
Carpeta=CostosNoIncluidos
Clave=Asiste.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CostosNoIncluidos.Asiste.FechaEmision]
Carpeta=CostosNoIncluidos
Clave=Asiste.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[CostosNoIncluidos.Columnas]
0=-2
1=-2
2=-2

3=-2
4=-2

5=-2
6=-2
7=-2
8=-2
[OtrosIngresos.GastoT.Mov]
Carpeta=OtrosIngresos
Clave=GastoT.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosIngresos.GastoT.MovID]
Carpeta=OtrosIngresos
Clave=GastoT.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosIngresos.GastoT.FechaEmision]
Carpeta=OtrosIngresos
Clave=GastoT.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro




[OtrosIngresos.Columnas]
0=-2
1=-2
2=-2


3=-2



[Presupuesto.Ejercicio]
Carpeta=Presupuesto
Clave=Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Presupuesto.Periodo]
Carpeta=Presupuesto
Clave=Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Presupuesto.Concepto]
Carpeta=Presupuesto
Clave=Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Presupuesto.MovMoneda]
Carpeta=Presupuesto
Clave=MovMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Presupuesto.Presupuesto]
Carpeta=Presupuesto
Clave=Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Presupuesto.GastoPendiente]
Carpeta=Presupuesto
Clave=GastoPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Presupuesto.GastoEjercido]
Carpeta=Presupuesto
Clave=GastoEjercido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Presupuesto.Disponible]
Carpeta=Presupuesto
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[CostosIncluidos.Asiste.Mov]
Carpeta=CostosIncluidos
Clave=Asiste.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[CostosIncluidos.Asiste.MovID]
Carpeta=CostosIncluidos
Clave=Asiste.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CostosIncluidos.Asiste.FechaEmision]
Carpeta=CostosIncluidos
Clave=Asiste.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[CostosNoIncluidos.AsisteD.Personal]
Carpeta=CostosNoIncluidos
Clave=AsisteD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco










[Ventas.Mov]
Carpeta=Ventas
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.MovID]
Carpeta=Ventas
Clave=MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.Cliente]
Carpeta=Ventas
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.Importe]
Carpeta=Ventas
Clave=Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.Impuestos]
Carpeta=Ventas
Clave=Impuestos
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ventas.ImporteTotal]
Carpeta=Ventas
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro























[PuntosCriticos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Puntos Críticos
Clave=PuntosCriticos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyPuntoCritico
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=ProyPuntoCritico.Proyecto = <T>{Info.Proyecto}<T>
[PuntosCriticos.ProyPuntoCritico.PuntoCritico]
Carpeta=PuntosCriticos
Clave=ProyPuntoCritico.PuntoCritico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[PuntosCriticos.ProyPuntoCritico.Descripcion]
Carpeta=PuntosCriticos
Clave=ProyPuntoCritico.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[PuntosCriticos.ProyPuntoCritico.Estado]
Carpeta=PuntosCriticos
Clave=ProyPuntoCritico.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[PuntosCriticos.ProyPuntoCritico.Avance]
Carpeta=PuntosCriticos
Clave=ProyPuntoCritico.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro




[PuntosCriticos.Columnas]
PuntoCritico=75
Descripcion=179
Estado=104
Avance=44














[Acciones.GastosMovPropiedades]
Nombre=GastosMovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=MovPropiedades
EjecucionCondicion=ConDatos(GastoT:GastoT.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoT:GastoT.ID)

[Acciones.GastosImprimir]
Nombre=GastosImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.GastosPreliminar]
Nombre=GastosPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.GastosExcel]
Nombre=GastosExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.GastosCampos]
Nombre=GastosCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Gastos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S













[Acciones.CostosIncluidosMovPropiedades]
Nombre=CostosIncluidosMovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=MovPropiedades

EjecucionCondicion=ConDatos(AsisteT:Asiste.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, AsisteT:Asiste.ID)
[Acciones.CostosIncluidosImprimir]
Nombre=CostosIncluidosImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=CostosIncluidos
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.CostosIncluidosPreliminar]
Nombre=CostosIncluidosPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=CostosIncluidos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.CostosIncluidosExcel]
Nombre=CostosIncluidosExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=CostosIncluidos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.CostosIncluidosCampos]
Nombre=CostosIncluidosCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=CostosIncluidos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S












[Acciones.CostosNoIncluidosMovPropiedades]
Nombre=CostosNoIncluidosMovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=MovPropiedades

EjecucionCondicion=ConDatos(AsisteT:Asiste.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>ASIS<T>)<BR>Asigna(Info.ID, AsisteT:Asiste.ID)
[Acciones.CostosNoIncluidosImprimir]
Nombre=CostosNoIncluidosImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=CostosNoIncluidos
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.CostosNoIncluidosPreliminar]
Nombre=CostosNoIncluidosPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=CostosNoIncluidos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.CostosNoIncluidosExcel]
Nombre=CostosNoIncluidosExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=CostosNoIncluidos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.CostosNoIncluidosCampos]
Nombre=CostosNoIncluidosCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=CostosNoIncluidos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



[Acciones.VentasMovPropiedades]
Nombre=VentasMovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=MovPropiedades

EjecucionCondicion=ConDatos(VentaNeta:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaNeta:ID)
[Acciones.VentasImprimir]
Nombre=VentasImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.VentasPreliminar]
Nombre=VentasPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.VentasExcel]
Nombre=VentasExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.VentasCampos]
Nombre=VentasCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



[Acciones.OtrosIngresosMovPropiedades]
Nombre=OtrosIngresosMovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=MovPropiedades


EjecucionCondicion=ConDatos(GastoT:GastoT.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoT:GastoT.ID)
[Acciones.OtrosIngresosImprimir]
Nombre=OtrosIngresosImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=OtrosIngresos
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.OtrosIngresosPreliminar]
Nombre=OtrosIngresosPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=OtrosIngresos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.OtrosIngresosExcel]
Nombre=OtrosIngresosExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=OtrosIngresos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.OtrosIngresosCampos]
Nombre=OtrosIngresosCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=OtrosIngresos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



[Acciones.GestionMovPropiedades]
Nombre=GestionMovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=MovPropiedades


EjecucionCondicion=ConDatos(GestionA:Gestion.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, GestionA:Gestion.ID)
[Acciones.GestionImprimir]
Nombre=GestionImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.GestionPreliminar]
Nombre=GestionPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.GestionExcel]
Nombre=GestionExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.GestionCampos]
Nombre=GestionCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Gestion
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





















[Gastos.ListaEnCaptura]
(Inicio)=GastoT.FechaEmision
GastoT.FechaEmision=GastoT.Proyecto
GastoT.Proyecto=GastoT.Concepto
GastoT.Concepto=GastoT.Importe
GastoT.Importe=(Fin)

[Gastos.ListaAcciones]
(Inicio)=GastosMovPropiedades
GastosMovPropiedades=GastosImprimir
GastosImprimir=GastosPreliminar
GastosPreliminar=GastosExcel
GastosExcel=GastosCampos
GastosCampos=(Fin)





[Ventas.ListaEnCaptura]
(Inicio)=Mov
Mov=MovID
MovID=Cliente
Cliente=Importe
Importe=Impuestos
Impuestos=ImporteTotal
ImporteTotal=(Fin)

[Ventas.ListaAcciones]
(Inicio)=VentasMovPropiedades
VentasMovPropiedades=VentasImprimir
VentasImprimir=VentasPreliminar
VentasPreliminar=VentasExcel
VentasExcel=VentasCampos
VentasCampos=(Fin)

[OtrosIngresos.ListaEnCaptura]
(Inicio)=GastoT.Mov
GastoT.Mov=GastoT.MovID
GastoT.MovID=GastoT.FechaEmision
GastoT.FechaEmision=(Fin)

[OtrosIngresos.ListaAcciones]
(Inicio)=OtrosIngresosMovPropiedades
OtrosIngresosMovPropiedades=OtrosIngresosImprimir
OtrosIngresosImprimir=OtrosIngresosPreliminar
OtrosIngresosPreliminar=OtrosIngresosExcel
OtrosIngresosExcel=OtrosIngresosCampos
OtrosIngresosCampos=(Fin)

[Gestion.ListaEnCaptura]
(Inicio)=Gestion.Mov
Gestion.Mov=Gestion.MovID
Gestion.MovID=Gestion.FechaEmision
Gestion.FechaEmision=(Fin)

[Gestion.ListaAcciones]
(Inicio)=GestionMovPropiedades
GestionMovPropiedades=GestionImprimir
GestionImprimir=GestionPreliminar
GestionPreliminar=GestionExcel
GestionExcel=GestionCampos
GestionCampos=(Fin)

[PuntosCriticos.ListaEnCaptura]
(Inicio)=ProyPuntoCritico.PuntoCritico
ProyPuntoCritico.PuntoCritico=ProyPuntoCritico.Descripcion
ProyPuntoCritico.Descripcion=ProyPuntoCritico.Estado
ProyPuntoCritico.Estado=ProyPuntoCritico.Avance
ProyPuntoCritico.Avance=(Fin)












































[Proyecto.ListaEnCaptura]
(Inicio)=Proy.Descripcion
Proy.Descripcion=Proy.Direccion
Proy.Direccion=Proy.Colonia
Proy.Colonia=Proy.CodigoPostal
Proy.CodigoPostal=Proy.Estado
Proy.Estado=Proy.Pais
Proy.Pais=Proy.Categoria
Proy.Categoria=Proy.Estatus
Proy.Estatus=Proy.FechaInicio
Proy.FechaInicio=Proy.FechaFin
Proy.FechaFin=(Fin)
























[CostosIncluidos.ListaEnCaptura]
(Inicio)=Asiste.Mov
Asiste.Mov=Asiste.MovID
Asiste.MovID=Asiste.FechaEmision
Asiste.FechaEmision=AsisteD.Cantidad
AsisteD.Cantidad=AsisteD.Costo
AsisteD.Costo=CostoTotal
CostoTotal=(Fin)

[CostosIncluidos.ListaAcciones]
(Inicio)=CostosIncluidosMovPropiedades
CostosIncluidosMovPropiedades=CostosIncluidosImprimir
CostosIncluidosImprimir=CostosIncluidosPreliminar
CostosIncluidosPreliminar=CostosIncluidosExcel
CostosIncluidosExcel=CostosIncluidosCampos
CostosIncluidosCampos=(Fin)

[CostosIncluidos.AsisteD.Cantidad]
Carpeta=CostosIncluidos
Clave=AsisteD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CostosIncluidos.CostoTotal]
Carpeta=CostosIncluidos
Clave=CostoTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CostosNoIncluidos.ListaEnCaptura]
(Inicio)=Asiste.Mov
Asiste.Mov=Asiste.MovID
Asiste.MovID=Asiste.FechaEmision
Asiste.FechaEmision=AsisteD.Personal
AsisteD.Personal=AsisteD.Cantidad
AsisteD.Cantidad=AsisteD.Costo
AsisteD.Costo=NombreCompleto
NombreCompleto=CostoTotal
CostoTotal=(Fin)

[CostosNoIncluidos.ListaAcciones]
(Inicio)=CostosNoIncluidosMovPropiedades
CostosNoIncluidosMovPropiedades=CostosNoIncluidosImprimir
CostosNoIncluidosImprimir=CostosNoIncluidosPreliminar
CostosNoIncluidosPreliminar=CostosNoIncluidosExcel
CostosNoIncluidosExcel=CostosNoIncluidosCampos
CostosNoIncluidosCampos=(Fin)

[CostosNoIncluidos.AsisteD.Cantidad]
Carpeta=CostosNoIncluidos
Clave=AsisteD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CostosNoIncluidos.AsisteD.Costo]
Carpeta=CostosNoIncluidos
Clave=AsisteD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CostosNoIncluidos.NombreCompleto]
Carpeta=CostosNoIncluidos
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[CostosNoIncluidos.CostoTotal]
Carpeta=CostosNoIncluidos
Clave=CostoTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco























[Presupuesto.ListaEnCaptura]
(Inicio)=Ejercicio
Ejercicio=Periodo
Periodo=Concepto
Concepto=MovMoneda
MovMoneda=Presupuesto
Presupuesto=GastoPendiente
GastoPendiente=GastoEjercido
GastoEjercido=Disponible
Disponible=(Fin)






[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Proyecto
Proyecto=Presupuesto
Presupuesto=Gastos
Gastos=CostosIncluidos
CostosIncluidos=CostosNoIncluidos
CostosNoIncluidos=Ventas
Ventas=OtrosIngresos
OtrosIngresos=Gestion
Gestion=PuntosCriticos
PuntosCriticos=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=(Fin)
