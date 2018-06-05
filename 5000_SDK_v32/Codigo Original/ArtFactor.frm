[Forma]
Clave=ArtFactor
Nombre=Factores de Costos
Icono=0
Modulos=INV
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=ArtFactor
CarpetaPrincipal=ArtFactor
PosicionInicialIzquierda=510
PosicionInicialArriba=358
PosicionInicialAltura=300
PosicionInicialAncho=259
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
VentanaEscCerrar=
PosicionInicialAlturaCliente=273

[ArtFactor]
Estilo=Hoja
Clave=ArtFactor
PermiteEditar=Si
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=ArtFactor
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=Si
HojaMostrarColumnas=Si
HojaMostrarRenglones=Si
HojaAjustarColumnas=
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=Si
CondicionEdicion=
GuardarPorRegistro=
HojaConfirmarEliminar=Si

[ArtFactor.ArtFactor.Factor]
Carpeta=ArtFactor
Clave=ArtFactor.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtFactor.ArtFactor.Importe]
Carpeta=ArtFactor
Clave=ArtFactor.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtFactor.Columnas]
Factor=167
Descripcion=241
Importe=61

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtFactor:ArtFactor.Factor)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[ArtFactor.ListaEnCaptura]
(Inicio)=ArtFactor.Factor
ArtFactor.Factor=ArtFactor.Importe
ArtFactor.Importe=(Fin)
