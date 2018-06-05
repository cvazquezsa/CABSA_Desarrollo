
[Forma]
Clave=MFAMovExcepcion
Icono=0
Modulos=(Todos)
Nombre=MFA - Excepción Movimiento Especifico

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=396
PosicionInicialAncho=505
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=387
PosicionInicialArriba=157
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAMovExcepcion
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

CarpetaVisible=S

[Lista.MFAMovExcepcion.Modulo]
Carpeta=Lista
Clave=MFAMovExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFAMovExcepcion.ModuloID]
Carpeta=Lista
Clave=MFAMovExcepcion.ModuloID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAMovimientoLista.Mov]
Carpeta=Lista
Clave=MFAMovimientoLista.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAMovimientoLista.MovID]
Carpeta=Lista
Clave=MFAMovimientoLista.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar  y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Modulo=50
ModuloID=124
Mov=124
MovID=124
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2



Empresa=45
[Lista.ListaEnCaptura]
(Inicio)=MFAMovExcepcion.Modulo
MFAMovExcepcion.Modulo=MFAMovExcepcion.ModuloID
MFAMovExcepcion.ModuloID=MFAMovimientoLista.Empresa
MFAMovimientoLista.Empresa=MFAMovimientoLista.Mov
MFAMovimientoLista.Mov=MFAMovimientoLista.MovID
MFAMovimientoLista.MovID=(Fin)

[Lista.MFAMovimientoLista.Empresa]
Carpeta=Lista
Clave=MFAMovimientoLista.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
