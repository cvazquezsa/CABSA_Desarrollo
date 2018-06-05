[Forma]
Clave=VINSeguro
Nombre=Seguros del VIN
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=399
PosicionInicialAncho=659
PosicionInicialIzquierda=310
PosicionInicialArriba=299
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.VIN
PosicionColumna1=52

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINSeguro
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMantenerSeleccion=S
FiltroGeneral=VINSeguro.VIN=<T>{Info.VIN}<T>

[Lista.Columnas]
Aseguradora=205
Poliza=73
TipoPoliza=66
FechaEmision=73
Vencimiento=78
TipoPlan=82
Estado=95
PrimaNeta=84
Observaciones=122
Deducible=78
PolizaTipo=101
PolizaPlan=75
PolizaEmision=72
PolizaVencimiento=70
CteAseguradora=66
Nombre=139

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

[Lista.VINSeguro.PolizaTipo]
Carpeta=Lista
Clave=VINSeguro.PolizaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
Vista=VINSeguro
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.VINSeguro.PolizaTipo]
Carpeta=Ficha
Clave=VINSeguro.PolizaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.Poliza]
Carpeta=Ficha
Clave=VINSeguro.Poliza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.PolizaPlan]
Carpeta=Ficha
Clave=VINSeguro.PolizaPlan
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.TipoDeducible]
Carpeta=Ficha
Clave=VINSeguro.TipoDeducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.PrimaNeta]
Carpeta=Ficha
Clave=VINSeguro.PrimaNeta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.VINSeguro.PolizaEstado]
Carpeta=Ficha
Clave=VINSeguro.PolizaEstado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.PolizaEmision]
Carpeta=Ficha
Clave=VINSeguro.PolizaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.PolizaVencimiento]
Carpeta=Ficha
Clave=VINSeguro.PolizaVencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VINSeguro.Observaciones]
Carpeta=Ficha
Clave=VINSeguro.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41x3
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
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

[Ficha.VINSeguro.CteAseguradora]
Carpeta=Ficha
Clave=VINSeguro.CteAseguradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.VINSeguro.CteAseguradora]
Carpeta=Lista
Clave=VINSeguro.CteAseguradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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
(Inicio)=VINSeguro.PolizaTipo
VINSeguro.PolizaTipo=VINSeguro.CteAseguradora
VINSeguro.CteAseguradora=Cte.Nombre
Cte.Nombre=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=VINSeguro.PolizaTipo
VINSeguro.PolizaTipo=VINSeguro.CteAseguradora
VINSeguro.CteAseguradora=Cte.Nombre
Cte.Nombre=VINSeguro.Poliza
VINSeguro.Poliza=VINSeguro.PolizaPlan
VINSeguro.PolizaPlan=VINSeguro.TipoDeducible
VINSeguro.TipoDeducible=VINSeguro.PrimaNeta
VINSeguro.PrimaNeta=VINSeguro.PolizaEstado
VINSeguro.PolizaEstado=VINSeguro.PolizaEmision
VINSeguro.PolizaEmision=VINSeguro.PolizaVencimiento
VINSeguro.PolizaVencimiento=VINSeguro.Observaciones
VINSeguro.Observaciones=(Fin)
