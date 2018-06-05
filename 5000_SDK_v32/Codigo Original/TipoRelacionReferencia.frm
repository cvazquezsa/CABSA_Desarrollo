
[Forma]
Clave=TipoRelacionReferencia
Icono=0
Modulos=(Todos)
Nombre=Tipos de Relacion de Referencia

ListaCarpetas=TipoRelacionReferencia
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
CarpetaPrincipal=TipoRelacionReferencia
PosicionInicialIzquierda=488
PosicionInicialArriba=206
PosicionInicialAlturaCliente=353
PosicionInicialAncho=303
[TipoRelacionReferencia]
Estilo=Hoja
Clave=TipoRelacionReferencia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoRelacionReferencia
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoRelacionReferencia.Descripcion
CarpetaVisible=S

[TipoRelacionReferencia.TipoRelacionReferencia.Descripcion]
Carpeta=TipoRelacionReferencia
Clave=TipoRelacionReferencia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=ventana
ClaveAccion=aceptar
Activo=S
Visible=S


GuardarAntes=S
[TipoRelacionReferencia.Columnas]
Descripcion=273


[Acciones.Envio]
Nombre=Envio
Boton=67
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Envio
Envio=(Fin)
