[Forma]
Clave=Talla
Nombre=Lista de Tallas
Icono=0
Modulos=INV
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Talla
PosicionInicialIzquierda=428
PosicionInicialArriba=238
PosicionInicialAltura=292
PosicionInicialAncho=167
CarpetaPrincipal=Talla
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S

[Talla]
Estilo=Hoja
Clave=Talla
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=Talla
Fuente={MS Sans Serif, 8, Negro, []}
CondicionEditar=FormaNormal
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=Si
HojaAjustarColumnas=Si
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Talla.Talla
CarpetaVisible=Si
PermiteEditar=Si
CondicionEdicion=FormaNormal
OtroOrden=Si
ListaOrden=Talla.Talla<TAB>(Acendente)
Pestana=
HojaConfirmarEliminar=Si

[Talla.Talla.Talla]
Carpeta=Talla
Clave=Talla.Talla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Talla.Columnas]
Talla=139
Descripcion=162

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
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Talla:Talla.Talla)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

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
