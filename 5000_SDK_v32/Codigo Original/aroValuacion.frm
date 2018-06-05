[Forma]
Clave=aroValuacion
Nombre=Valuación de Riesgos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=521
PosicionInicialArriba=268
PosicionInicialAlturaCliente=526
PosicionInicialAncho=779
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroValuacion
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
OtroOrden=S
ListaOrden=(Lista)

[Lista.aroValuacion.ValorSeveridad]
Carpeta=Lista
Clave=aroValuacion.ValorSeveridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.ValorOcurrencia]
Carpeta=Lista
Clave=aroValuacion.ValorOcurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.ValorDeteccion]
Carpeta=Lista
Clave=aroValuacion.ValorDeteccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.CalificacionSeveridad]
Carpeta=Lista
Clave=aroValuacion.CalificacionSeveridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.CalificacionOcurrencia]
Carpeta=Lista
Clave=aroValuacion.CalificacionOcurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.CalificacionDeteccion]
Carpeta=Lista
Clave=aroValuacion.CalificacionDeteccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.Nivel]
Carpeta=Lista
Clave=aroValuacion.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroValuacion.Valor]
Carpeta=Lista
Clave=aroValuacion.Valor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ValorSeveridad=82
ValorOcurrencia=84
ValorDeteccion=81
CalificacionSeveridad=112
CalificacionOcurrencia=116
CalificacionDeteccion=112
Nivel=30
Nombre=65
Valor=60

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

[Lista.aroNivel.Nombre]
Carpeta=Lista
Clave=aroNivel.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaEnCaptura]
(Inicio)=aroValuacion.Nivel
aroValuacion.Nivel=aroNivel.Nombre
aroNivel.Nombre=aroValuacion.CalificacionSeveridad
aroValuacion.CalificacionSeveridad=aroValuacion.CalificacionOcurrencia
aroValuacion.CalificacionOcurrencia=aroValuacion.CalificacionDeteccion
aroValuacion.CalificacionDeteccion=aroValuacion.ValorSeveridad
aroValuacion.ValorSeveridad=aroValuacion.ValorOcurrencia
aroValuacion.ValorOcurrencia=aroValuacion.ValorDeteccion
aroValuacion.ValorDeteccion=aroValuacion.Valor
aroValuacion.Valor=(Fin)

[Lista.ListaOrden]
(Inicio)=aroValuacion.Nivel<TAB>(Decendente)
aroValuacion.Nivel<TAB>(Decendente)=aroValuacion.CalificacionSeveridad<TAB>(Acendente)
aroValuacion.CalificacionSeveridad<TAB>(Acendente)=aroValuacion.CalificacionOcurrencia<TAB>(Acendente)
aroValuacion.CalificacionOcurrencia<TAB>(Acendente)=aroValuacion.CalificacionDeteccion<TAB>(Acendente)
aroValuacion.CalificacionDeteccion<TAB>(Acendente)=aroValuacion.Valor<TAB>(Acendente)
aroValuacion.Valor<TAB>(Acendente)=(Fin)
