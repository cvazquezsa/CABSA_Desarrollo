[Forma]
Clave=TipoTasa
Nombre=Tipos Tasas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=284
PosicionInicialArriba=209
PosicionInicialAlturaCliente=447
PosicionInicialAncho=872
PosicionColumna1=46
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=394

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoTasa
Fuente={Tahoma, 8, Negro, []}
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaMostrarRenglones=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMantenerSeleccion=S

[Lista.TipoTasa.TipoTasa]
Carpeta=Lista
Clave=TipoTasa.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TipoTasa
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.TipoTasa.TipoTasa]
Carpeta=Ficha
Clave=TipoTasa.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.TipoTasa.TasaFija]
Carpeta=Ficha
Clave=TipoTasa.TasaFija
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Ficha.TipoTasa.TasaBase]
Carpeta=Ficha
Clave=TipoTasa.TasaBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.TipoTasa.SobreTasa]
Carpeta=Ficha
Clave=TipoTasa.SobreTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.TipoTasa.SobreTasaEn]
Carpeta=Ficha
Clave=TipoTasa.SobreTasaEn
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
TipoTasa=88
Descripcion=271

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

[Lista.TipoTasa.Descripcion]
Carpeta=Lista
Clave=TipoTasa.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.Descripcion]
Carpeta=Ficha
Clave=TipoTasa.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.TipoTasa.TasaBase2]
Carpeta=Ficha
Clave=TipoTasa.TasaBase2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.TasaBase3]
Carpeta=Ficha
Clave=TipoTasa.TasaBase3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Ficha.TipoTasa.EsTasaFija]
Carpeta=Ficha
Clave=TipoTasa.EsTasaFija
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.TasaTotalMinima]
Carpeta=Ficha
Clave=TipoTasa.TasaTotalMinima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.TasaTotalMaxima]
Carpeta=Ficha
Clave=TipoTasa.TasaTotalMaxima
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.Estatus]
Carpeta=Ficha
Clave=TipoTasa.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.MoratoriosFactor]
Carpeta=Ficha
Clave=TipoTasa.MoratoriosFactor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.ImpuestoIncluido]
Carpeta=Ficha
Clave=TipoTasa.ImpuestoIncluido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.PagoAnticipadoFactor]
Carpeta=Ficha
Clave=TipoTasa.PagoAnticipadoFactor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.RetencionPuntos]
Carpeta=Ficha
Clave=TipoTasa.RetencionPuntos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.TipoTasa.ComisionPorcentaje]
Carpeta=Ficha
Clave=TipoTasa.ComisionPorcentaje
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TipoTasa.TipoTasa
TipoTasa.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=TipoTasa.TipoTasa
TipoTasa.TipoTasa=TipoTasa.Descripcion
TipoTasa.Descripcion=TipoTasa.EsTasaFija
TipoTasa.EsTasaFija=TipoTasa.TasaFija
TipoTasa.TasaFija=TipoTasa.TasaBase
TipoTasa.TasaBase=TipoTasa.TasaBase2
TipoTasa.TasaBase2=TipoTasa.TasaBase3
TipoTasa.TasaBase3=TipoTasa.SobreTasa
TipoTasa.SobreTasa=TipoTasa.SobreTasaEn
TipoTasa.SobreTasaEn=TipoTasa.TasaTotalMinima
TipoTasa.TasaTotalMinima=TipoTasa.TasaTotalMaxima
TipoTasa.TasaTotalMaxima=TipoTasa.MoratoriosFactor
TipoTasa.MoratoriosFactor=TipoTasa.PagoAnticipadoFactor
TipoTasa.PagoAnticipadoFactor=TipoTasa.RetencionPuntos
TipoTasa.RetencionPuntos=TipoTasa.ComisionPorcentaje
TipoTasa.ComisionPorcentaje=TipoTasa.ImpuestoIncluido
TipoTasa.ImpuestoIncluido=TipoTasa.Estatus
TipoTasa.Estatus=(Fin)
