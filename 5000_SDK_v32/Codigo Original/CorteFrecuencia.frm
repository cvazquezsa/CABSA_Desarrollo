[Forma]
Clave=CorteFrecuencia
Icono=0
Modulos=CORTE
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionInicialIzquierda=435
PosicionInicialArriba=172
PosicionInicialAltura=373
PosicionInicialAncho=496
PosicionInicialAlturaCliente=346

MovModulo=CORTE
Nombre=Frecuencias de Corte
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CorteFrecuencia
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CorteFrecuencia.Frecuencia
CarpetaVisible=S
PestanaNombre=Lista
HojaTitulos=S
HojaMostrarColumnas=S


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtGrupo:ArtGrupo.Grupo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Grupo=218
csExibith=64
csDescripcion=304
csDescuento=67
Tarifa=85
TablaComision=113
Puntos=40
Clave=81
Comision=62
ComisionImporte=64

Frecuencia=304
[Detalles.ArtGrupo.Grupo]
Carpeta=Detalles
Clave=ArtGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.ArtGrupo.Descripcion]
Carpeta=Detalles
Clave=ArtGrupo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.ArtGrupo.Descuento]
Carpeta=Detalles
Clave=ArtGrupo.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=ArtGrupo.Grupo
ArtGrupo.Grupo=ArtGrupo.Clave
ArtGrupo.Clave=ArtGrupo.Puntos
ArtGrupo.Puntos=ArtGrupo.TablaComision
ArtGrupo.TablaComision=(Fin)

[Lista.CorteFrecuencia.Frecuencia]
Carpeta=Lista
Clave=CorteFrecuencia.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
