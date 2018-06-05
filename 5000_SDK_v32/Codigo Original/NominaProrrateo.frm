
[Forma]
Clave=NominaProrrateo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Prorrateo
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=433
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=346
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Prorrateo
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaProrrateo
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
ListaEnCaptura=NominaProrrateo.Prorrateo
ListaOrden=NominaProrrateo.Prorrateo<TAB>(Acendente)
CarpetaVisible=S

[Lista.NominaProrrateo.Prorrateo]
Carpeta=Lista
Clave=NominaProrrateo.Prorrateo
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
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Prorrateo=304

[Acciones.Prorrateo]
Nombre=Prorrateo
Boton=61
NombreEnBoton=S
NombreDesplegar=Prorrateo
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NominaProrrateoD
Activo=S
ConCondicion=S
Visible=S

EjecucionCondicion=ConDatos(NominaProrrateo:NominaProrrateo.Prorrateo)
Antes=S
AntesExpresiones=Asigna(Info.Concepto, NominaProrrateo:NominaProrrateo.Prorrateo)
DespuesGuardar=S


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Prorrateo
Prorrateo=(Fin)
