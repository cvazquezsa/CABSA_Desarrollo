
[Forma]
Clave=ProspectoTipo
Icono=0
Modulos=(Todos)
MovModulo=ProspectoTipo
Nombre=ProspectoTipo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=288
PosicionInicialAncho=275
PosicionInicialIzquierda=459
PosicionInicialArriba=198
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Tipos de Prospecto
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoTipo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[Lista.ProspectoTipo.Tipo]
Carpeta=Lista
Clave=ProspectoTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProspectoTipo.Orden]
Carpeta=Lista
Clave=ProspectoTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ProspectoTipo.Tipo
ProspectoTipo.Tipo=ProspectoTipo.Orden
ProspectoTipo.Orden=(Fin)

[Lista.Columnas]
Tipo=181
Orden=64

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
