
[Forma]
Clave=ParCartaPorte
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Mostrar Movimientos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=530
PosicionInicialArriba=265
PosicionInicialAlturaCliente=158
PosicionInicialAncho=305
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata

PermiteEditar=S

[Lista.Info.FechaD]
Carpeta=Lista
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Info.FechaA]
Carpeta=Lista
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S

ListaAccionesMultiples=(Lista)
GuardarAntes=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S



EspacioPrevio=S










[Lista.Temp.Modulo]
Carpeta=Lista
Clave=Temp.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Acciones.Aceptar.VerMovsCartaPorte]
Nombre=VerMovsCartaPorte
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=EjecutarSQL(<T>EXEC spMovCartaPorte :nEstacion, :tEmpresa, :tModulo, :fFechaD, :fFechaA<T>, EstacionTrabajo, Empresa, Temp.Modulo, Info.FechaD, Info.FechaA )
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







[Lista.ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Temp.Modulo
Temp.Modulo=(Fin)




[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=VerMovsCartaPorte
VerMovsCartaPorte=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)
