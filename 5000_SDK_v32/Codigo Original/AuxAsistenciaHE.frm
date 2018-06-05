
[Forma]
Clave=AuxAsistenciaHE
Icono=0
Modulos=(Todos)
Nombre=Horas Extras del Periodo

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=189
PosicionInicialArriba=116
PosicionInicialAlturaCliente=428
PosicionInicialAncho=951
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
PosicionSec1=105
AccionesCentro=S
BarraHerramientas=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=EjecutarSQL(<T>spVerMinutosTiempoExtra :nID, :tEmpresa, :fFechaD, :fFechaA, 1<T>, Info.ID ,EMPRESA, Info.FechaD, Info.FechaA)<BR>ActualizarForma<BR>ActualizarVista
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S






















Vista=AuxAsistenciaAsiste
PermiteEditar=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
GuardarAlSalir=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
FiltroGeneral={<T>Asiste.ID =<T>&Info.ID}
[Lista.Columnas]
Personal=64
Empresa=45
FechaD=64
FechaA=94
Generar=53
Semana1Dia1=69
Semana1Dia2=69
Semana1Dia3=69
Semana1Dia4=69
Semana1Dia5=69
Semana1Dia6=69
Semana1Dia7=69
Semana2Dia1=69
Semana2Dia2=69
Semana2Dia3=69
Semana2Dia4=69
Semana2Dia5=69
Semana2Dia6=69
Semana2Dia7=69
TotalHoras=64

0=-2
1=88
2=-2
3=113
4=88
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







UltimoCambio=94
FechaEmision=94
FechaAplicacion=94
Proyecto=304
ID=64
MovID=64
Estatus=94
Mov=64
[Acciones.Aceptar]
Nombre=Aceptar
Boton=21
NombreDesplegar=&Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

EnBarraHerramientas=S

[Acciones.Generara]
Nombre=Generara
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Horas Extras
EnBarraHerramientas=S
TipoAccion=expresion

GuardarAntes=S








EspacioPrevio=S





















Multiple=S
ListaAccionesMultiples=(Lista)
Activo=S
VisibleCondicion=Info.TareaID = 1
[Detalle.Columnas]
Personal=62
Generar=55
Semana1Dia1=88
Semana1Dia2=85
Semana1Dia3=90
Semana1Dia4=84
Semana1Dia5=80
Semana1Dia6=83
Semana1Dia7=84
Semana2Dia1=82
Semana2Dia2=81
Semana2Dia3=83
Semana2Dia4=80
Semana2Dia5=82
Semana2Dia6=82
Semana2Dia7=83
TotalHoras=64















TotalS1=78
TotalS2=78
[Acciones.Ver]
Nombre=Ver
Boton=73
NombreEnBoton=S
NombreDesplegar=&Ver Detalle
EspacioPrevio=S








Multiple=S
ListaAccionesMultiples=(Lista)
EnBarraHerramientas=S
Activo=S
VisibleCondicion=Info.TareaID = 1
[Detalle.LlaveLocal]
(Inicio)=AuxAsistenciaHE.FechaD
AuxAsistenciaHE.FechaD=AuxAsistenciaHE.FechaA
AuxAsistenciaHE.FechaA=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=Asiste.FechaD
Asiste.FechaD=Asiste.FechaA
Asiste.FechaA=(Fin)








[Acciones.Ver.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S






[Acciones.Ver.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
























Expresion=Asigna(Info.Cantidad, SQL(<T>SELECT COUNT(*) FROM Asiste A JOIN AsisteD B ON A.ID = B.ID JOIN MovTipo C ON A.Mov = C.Mov WHERE A.FechaD = :fFechaD AND A.FechaA = :fFechaA AND C.Clave = :tClave AND A.Estatus <> :tEstatus<T>,AuxAsistenciaAsiste:Asiste.FechaD, AuxAsistenciaAsiste:Asiste.FechaA, <T>ASIS.C<T>, <T>CANCELADO<T>))<BR>Si<BR>  Info.Cantidad = 0<BR>Entonces<BR>  Informacion(<T>No existe información con las fechas proporcionadas<T>)<BR>Sino<BR>    EjecutarSQL(<T>spVerMinutosTiempoExtra :nID, :tEmpresa, :fFechaD, :fFechaA, 0<T>, Info.ID, EMPRESA, AuxAsistenciaAsiste:Asiste.FechaD, AuxAsistenciaAsiste:Asiste.FechaA)<BR>ActualizarForma<BR>ActualizarVista<BR> Fin
[Acciones.Excel]
Nombre=Excel
Boton=115
NombreEnBoton=S
NombreDesplegar=&Excel
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



















EspacioPrevio=S
[Lista.Asiste.FechaD]
Carpeta=Lista
Clave=Asiste.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.Asiste.FechaA]
Carpeta=Lista
Clave=Asiste.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















Tamano=20
[Acciones.Abrir]
Nombre=Abrir
Boton=108
NombreEnBoton=S
NombreDesplegar=C&onsultar
EnBarraHerramientas=S
EspacioPrevio=S
Visible=S









Multiple=S
ListaAccionesMultiples=Expression

Activo=S
[Lista.Asiste.Mov]
Carpeta=Lista
Clave=Asiste.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Asiste.MovID]
Carpeta=Lista
Clave=Asiste.MovID
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco









[Acciones.Abrir.ListaAccionesMultiples]
(Inicio)=AbreLista
AbreLista=ActualizaVista
ActualizaVista=(Fin)









[Acciones.Abrir.Expression]
Nombre=Expression
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=FormaModal(<T>AsistenciaCorteLista<T>)<BR>ActualizarVista
[DetalleS2.AuxAsistenciaHE.Generar]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Generar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Personal]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[DetalleS2.AuxAsistenciaHE.Semana2Dia1]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Semana2Dia2]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Semana2Dia3]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Semana2Dia4]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Semana2Dia5]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Semana2Dia6]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[DetalleS2.AuxAsistenciaHE.Semana2Dia7]
Carpeta=DetalleS2
Clave=AuxAsistenciaHE.Semana2Dia7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco











[DetalleS1.Columnas]
Generar=64
Personal=64
Semana1Dia1=78
Semana1Dia2=78
Semana1Dia3=78
Semana1Dia4=78
Semana1Dia5=78
Semana1Dia6=78
Semana1Dia7=78

[DetalleS2.Columnas]
Generar=64
Personal=64
FechaD=94
FechaA=94
Semana2Dia1=78
Semana2Dia2=78
Semana2Dia3=78
Semana2Dia4=78
Semana2Dia5=78
Semana2Dia6=78
Semana2Dia7=78

[DetalleS1.ListaEnCaptura]
(Inicio)=AuxAsistenciaHE.Generar
AuxAsistenciaHE.Generar=AuxAsistenciaHE.Personal
AuxAsistenciaHE.Personal=AuxAsistenciaHE.Semana1Dia1
AuxAsistenciaHE.Semana1Dia1=AuxAsistenciaHE.Semana1Dia2
AuxAsistenciaHE.Semana1Dia2=AuxAsistenciaHE.Semana1Dia3
AuxAsistenciaHE.Semana1Dia3=AuxAsistenciaHE.Semana1Dia4
AuxAsistenciaHE.Semana1Dia4=AuxAsistenciaHE.Semana1Dia5
AuxAsistenciaHE.Semana1Dia5=AuxAsistenciaHE.Semana1Dia6
AuxAsistenciaHE.Semana1Dia6=AuxAsistenciaHE.Semana1Dia7
AuxAsistenciaHE.Semana1Dia7=(Fin)

[DetalleS2.ListaEnCaptura]
(Inicio)=AuxAsistenciaHE.Generar
AuxAsistenciaHE.Generar=AuxAsistenciaHE.Personal
AuxAsistenciaHE.Personal=AuxAsistenciaHE.Semana2Dia1
AuxAsistenciaHE.Semana2Dia1=AuxAsistenciaHE.Semana2Dia2
AuxAsistenciaHE.Semana2Dia2=AuxAsistenciaHE.Semana2Dia3
AuxAsistenciaHE.Semana2Dia3=AuxAsistenciaHE.Semana2Dia4
AuxAsistenciaHE.Semana2Dia4=AuxAsistenciaHE.Semana2Dia5
AuxAsistenciaHE.Semana2Dia5=AuxAsistenciaHE.Semana2Dia6
AuxAsistenciaHE.Semana2Dia6=AuxAsistenciaHE.Semana2Dia7
AuxAsistenciaHE.Semana2Dia7=(Fin)



[Detalle]
Estilo=Hoja
Clave=Detalle
PermiteEditar=S
GuardarPorRegistro=S
GuardarAlSalir=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=AuxAsistenciaHE
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaIndicador=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=AuxAsistenciaHE.ID = {Info.Id}
CondicionEdicion=Info.TareaID = 1
[Detalle.AuxAsistenciaHE.Generar]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Generar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Personal]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana1Dia1]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

ColorFondo=Blanco
[Detalle.AuxAsistenciaHE.Semana1Dia2]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana1Dia3]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana1Dia4]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana1Dia5]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana1Dia6]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana1Dia7]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana1Dia7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia1]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia2]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia3]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia4]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia5]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia6]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.AuxAsistenciaHE.Semana2Dia7]
Carpeta=Detalle
Clave=AuxAsistenciaHE.Semana2Dia7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





[Detalle.TotalS1]
Carpeta=Detalle
Clave=TotalS1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00D7FBC6

[Detalle.TotalS2]
Carpeta=Detalle
Clave=TotalS2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$00D7FBC6





















[Acciones.Generara.expresion]
Nombre=expresion
Boton=0
TipoAccion=expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Evento, SQL(<T>EXEC spEjecutaTiempoExtra :nID, :tEmpresa, :nSucursal, :nEstacion, :tUsuario<T>, Info.ID, Empresa, Info.Sucursal, EstacionTrabajo, Usuario))<BR>Si<BR>  Info.Evento = <T>Proceso concluido.<T><BR>Entonces<BR>  Asigna(Info.TareaID, 0)<BR>  Informacion(<T>Proceso concluido.<T>)<BR>Sino<BR>  Informacion(<T>Las Fechas de Corte deben ser maximo de 2 semanas y minimo de 1 semana.<T>)<BR>Fin
[Acciones.Generara.exp]
Nombre=exp
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S














Expresion=ActualizarForma<BR>ActualizarVista
[Lista.ListaEnCaptura]
(Inicio)=Asiste.Mov
Asiste.Mov=Asiste.MovID
Asiste.MovID=Asiste.FechaD
Asiste.FechaD=Asiste.FechaA
Asiste.FechaA=(Fin)










[Acciones.Ver.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)



[Acciones.Generara.ListaAccionesMultiples]
(Inicio)=expresion
expresion=exp
exp=(Fin)





[Detalle.ListaEnCaptura]
(Inicio)=AuxAsistenciaHE.Generar
AuxAsistenciaHE.Generar=AuxAsistenciaHE.Personal
AuxAsistenciaHE.Personal=AuxAsistenciaHE.Semana1Dia1
AuxAsistenciaHE.Semana1Dia1=AuxAsistenciaHE.Semana1Dia2
AuxAsistenciaHE.Semana1Dia2=AuxAsistenciaHE.Semana1Dia3
AuxAsistenciaHE.Semana1Dia3=AuxAsistenciaHE.Semana1Dia4
AuxAsistenciaHE.Semana1Dia4=AuxAsistenciaHE.Semana1Dia5
AuxAsistenciaHE.Semana1Dia5=AuxAsistenciaHE.Semana1Dia6
AuxAsistenciaHE.Semana1Dia6=AuxAsistenciaHE.Semana1Dia7
AuxAsistenciaHE.Semana1Dia7=TotalS1
TotalS1=AuxAsistenciaHE.Semana2Dia1
AuxAsistenciaHE.Semana2Dia1=AuxAsistenciaHE.Semana2Dia2
AuxAsistenciaHE.Semana2Dia2=AuxAsistenciaHE.Semana2Dia3
AuxAsistenciaHE.Semana2Dia3=AuxAsistenciaHE.Semana2Dia4
AuxAsistenciaHE.Semana2Dia4=AuxAsistenciaHE.Semana2Dia5
AuxAsistenciaHE.Semana2Dia5=AuxAsistenciaHE.Semana2Dia6
AuxAsistenciaHE.Semana2Dia6=AuxAsistenciaHE.Semana2Dia7
AuxAsistenciaHE.Semana2Dia7=TotalS2
TotalS2=(Fin)























[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Abrir
Abrir=Excel
Excel=Ver
Ver=Generara
Generara=(Fin)
