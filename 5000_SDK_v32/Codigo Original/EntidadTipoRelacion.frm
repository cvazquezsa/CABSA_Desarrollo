
[Forma]
Clave=EntidadTipoRelacion
Icono=0
Modulos=(Todos)
Nombre=Tipos Relaciones - Entidades

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=490
PosicionInicialArriba=200
PosicionInicialAlturaCliente=332
PosicionInicialAncho=385
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EntidadTipoRelacion
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
[Lista.EntidadTipoRelacion.TipoRelacion]
Carpeta=Lista
Clave=EntidadTipoRelacion.TipoRelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TipoRelacion=223

ContactoTipo=124
[Lista.ListaEnCaptura]
(Inicio)=EntidadTipoRelacion.ContactoTipo
EntidadTipoRelacion.ContactoTipo=EntidadTipoRelacion.TipoRelacion
EntidadTipoRelacion.TipoRelacion=(Fin)

[Lista.EntidadTipoRelacion.ContactoTipo]
Carpeta=Lista
Clave=EntidadTipoRelacion.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
