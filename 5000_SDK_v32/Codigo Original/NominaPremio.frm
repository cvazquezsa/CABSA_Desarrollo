[Forma]
Clave=NominaPremio
Nombre=Premios
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=342
PosicionInicialArriba=299
PosicionInicialAlturaCliente=391
PosicionInicialAncho=595
PosicionColumna1=47
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaPremio
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NominaPremio.Nombre
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.Columnas]
Sucursal=46
Nivel=93
Articulo=124
Linea=134
Tipo=124
Nombre=244
Estatus=94
FechaD=94
FechaA=94

[Lista.NominaPremio.Nombre]
Carpeta=Lista
Clave=NominaPremio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.Nombre]
Carpeta=Ficha
Clave=NominaPremio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.NominaPremio.Nivel]
Carpeta=Ficha
Clave=NominaPremio.Nivel
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

[Acciones.Suc]
Nombre=Suc
Boton=47
NombreEnBoton=S
NombreDesplegar=&Sucursales
EnBarraHerramientas=S
TipoAccion=Formas
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
ClaveAccion=NominaPremioSuc
ConCondicion=S
ActivoCondicion=NominaPremio:NominaPremio.Nivel<><T>Agente<T>
EjecucionCondicion=ConDatos(NominaPremio:NominaPremio.Nombre)
AntesExpresiones=Asigna(Info.ID, NominaPremio:NominaPremio.ID)<BR>Asigna(Info.Nombre, NominaPremio:NominaPremio.Nombre)<BR>Asigna(Info.Nivel, NominaPremio:NominaPremio.Nivel)

[Ficha.NominaPremio.Estatus]
Carpeta=Ficha
Clave=NominaPremio.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Premios]
Nombre=Premios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Premios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
Antes=S
DespuesGuardar=S
Visible=S
ConCondicion=S
ClaveAccion=NominaPremioAgente
ActivoCondicion=NominaPremio:NominaPremio.Nivel=<T>Agente<T>
EjecucionCondicion=ConDatos(NominaPremio:NominaPremio.Nombre)
AntesExpresiones=Asigna(Info.ID, NominaPremio:NominaPremio.ID)<BR>Asigna(Info.Nombre, NominaPremio:NominaPremio.Nombre)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NominaPremio
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

[Ficha.NominaPremio.Articulo]
Carpeta=Ficha
Clave=NominaPremio.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Ficha.NominaPremio.Linea]
Carpeta=Ficha
Clave=NominaPremio.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.Meta]
Carpeta=Ficha
Clave=NominaPremio.Meta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Ficha.NominaPremio.MetaCantidad]
Carpeta=Ficha
Clave=NominaPremio.MetaCantidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.MetaPorcentaje]
Carpeta=Ficha
Clave=NominaPremio.MetaPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.TablaImpuestos]
Carpeta=Ficha
Clave=NominaPremio.TablaImpuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.PersonalGrupo]
Carpeta=Ficha
Clave=NominaPremio.PersonalGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.PenalizacionPorcentaje]
Carpeta=Ficha
Clave=NominaPremio.PenalizacionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NominaPremio.PenalizacionCuota]
Carpeta=Ficha
Clave=NominaPremio.PenalizacionCuota
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
Eliminar=Suc
Suc=Premios
Premios=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=NominaPremio.Nombre
NominaPremio.Nombre=NominaPremio.PersonalGrupo
NominaPremio.PersonalGrupo=NominaPremio.Nivel
NominaPremio.Nivel=NominaPremio.TablaImpuestos
NominaPremio.TablaImpuestos=NominaPremio.Estatus
NominaPremio.Estatus=NominaPremio.Articulo
NominaPremio.Articulo=Art.Descripcion1
Art.Descripcion1=NominaPremio.Linea
NominaPremio.Linea=NominaPremio.Meta
NominaPremio.Meta=NominaPremio.MetaCantidad
NominaPremio.MetaCantidad=NominaPremio.MetaPorcentaje
NominaPremio.MetaPorcentaje=NominaPremio.PenalizacionPorcentaje
NominaPremio.PenalizacionPorcentaje=NominaPremio.PenalizacionCuota
NominaPremio.PenalizacionCuota=(Fin)
