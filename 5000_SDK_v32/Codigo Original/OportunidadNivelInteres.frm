
[Forma]
Clave=OportunidadNivelInteres
Icono=4
Modulos=(Todos)
Nombre=Nivel de Interés
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=NivelInteres
CarpetaPrincipal=NivelInteres
ListaAcciones=(Lista)
PosicionInicialIzquierda=421
PosicionInicialArriba=188
PosicionInicialAlturaCliente=314
PosicionInicialAncho=365
MovModulo=OPORT
[NivelInteres]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Nivel de Interés
Clave=NivelInteres
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadNivelInteres
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
ListaEnCaptura=OportunidadNivelInteres.NivelInteres
CarpetaVisible=S

[NivelInteres.OportunidadNivelInteres.NivelInteres]
Carpeta=NivelInteres
Clave=OportunidadNivelInteres.NivelInteres
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S


ActivoCondicion=Usuario.EnviarExcel
[NivelInteres.Columnas]
NivelInteres=304





































































[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
