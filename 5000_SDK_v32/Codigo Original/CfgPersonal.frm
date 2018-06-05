[Forma]
Clave=CfgPersonal
Nombre=Configuración del Personal
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=189
PosicionInicialArriba=205
PosicionInicialAlturaCliente=323
PosicionInicialAncho=646
PosicionColumna1=39
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgPersonal
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CfgPersonal.Configuracion
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.CfgPersonal.Configuracion]
Carpeta=Lista
Clave=CfgPersonal.Configuracion
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
Vista=CfgPersonal
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.CfgPersonal.Configuracion]
Carpeta=Ficha
Clave=CfgPersonal.Configuracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

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

[Lista.Columnas]
Configuracion=216

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

[Ficha.CfgPersonal.Sueldo]
Carpeta=Ficha
Clave=CfgPersonal.Sueldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgPersonal.Faltas]
Carpeta=Ficha
Clave=CfgPersonal.Faltas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgPersonal.Incapacidades]
Carpeta=Ficha
Clave=CfgPersonal.Incapacidades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgPersonal.RetardosFalta]
Carpeta=Ficha
Clave=CfgPersonal.RetardosFalta
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Prestaciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Prestaciones
Clave=Prestaciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CfgPersonal
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

[Prestaciones.CfgPersonal.Configuracion]
Carpeta=Prestaciones
Clave=CfgPersonal.Configuracion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Prestaciones.CfgPersonal.Vales]
Carpeta=Prestaciones
Clave=CfgPersonal.Vales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prestaciones.CfgPersonal.ValesPorcentaje]
Carpeta=Prestaciones
Clave=CfgPersonal.ValesPorcentaje
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Prestaciones.CfgPersonal.ValesBase]
Carpeta=Prestaciones
Clave=CfgPersonal.ValesBase
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prestaciones.CfgPersonal.PremioAsistencia]
Carpeta=Prestaciones
Clave=CfgPersonal.PremioAsistencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prestaciones.CfgPersonal.PremioAsistenciaPorcentaje]
Carpeta=Prestaciones
Clave=CfgPersonal.PremioAsistenciaPorcentaje
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Prestaciones.CfgPersonal.PremioAsistenciaBase]
Carpeta=Prestaciones
Clave=CfgPersonal.PremioAsistenciaBase
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prestaciones.CfgPersonal.PremioPuntualidad]
Carpeta=Prestaciones
Clave=CfgPersonal.PremioPuntualidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Prestaciones.CfgPersonal.PremioPuntualidadPorcentaje]
Carpeta=Prestaciones
Clave=CfgPersonal.PremioPuntualidadPorcentaje
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=8

[Prestaciones.CfgPersonal.PremioPuntualidadBase]
Carpeta=Prestaciones
Clave=CfgPersonal.PremioPuntualidadBase
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DiasEspeciales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Días Especiales
Clave=DiasEspeciales
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CfgPersonal
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
PermiteEditar=S

[DiasEspeciales.CfgPersonal.Configuracion]
Carpeta=DiasEspeciales
Clave=CfgPersonal.Configuracion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[DiasEspeciales.CfgPersonal.DomingosLaborados]
Carpeta=DiasEspeciales
Clave=CfgPersonal.DomingosLaborados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[DiasEspeciales.CfgPersonal.DomingosLaboradosFactor]
Carpeta=DiasEspeciales
Clave=CfgPersonal.DomingosLaboradosFactor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[DiasEspeciales.CfgPersonal.DomingosPrima]
Carpeta=DiasEspeciales
Clave=CfgPersonal.DomingosPrima
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[DiasEspeciales.CfgPersonal.FestivosLaborados]
Carpeta=DiasEspeciales
Clave=CfgPersonal.FestivosLaborados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[DiasEspeciales.CfgPersonal.FestivosLaboradosFactor]
Carpeta=DiasEspeciales
Clave=CfgPersonal.FestivosLaboradosFactor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[DiasEspeciales.CfgPersonal.DescansosLaborados]
Carpeta=DiasEspeciales
Clave=CfgPersonal.DescansosLaborados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[DiasEspeciales.CfgPersonal.DescansosLaboradosFactor]
Carpeta=DiasEspeciales
Clave=CfgPersonal.DescansosLaboradosFactor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[DiasEspeciales.CfgPersonal.DomingosEnJornada]
Carpeta=DiasEspeciales
Clave=CfgPersonal.DomingosEnJornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgPersonal.HorasExtras]
Carpeta=Ficha
Clave=CfgPersonal.HorasExtras
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vacaciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Vacaciones
Clave=Vacaciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CfgPersonal
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

[Vacaciones.CfgPersonal.Configuracion]
Carpeta=Vacaciones
Clave=CfgPersonal.Configuracion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Vacaciones.CfgPersonal.VacacionesPagoPrima]
Carpeta=Vacaciones
Clave=CfgPersonal.VacacionesPagoPrima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vacaciones.CfgPersonal.VacacionesPrima]
Carpeta=Vacaciones
Clave=CfgPersonal.VacacionesPrima
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vacaciones.CfgPersonal.VacacionesDisfrutadas]
Carpeta=Vacaciones
Clave=CfgPersonal.VacacionesDisfrutadas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vacaciones.CfgPersonal.VacacionesPagadas]
Carpeta=Vacaciones
Clave=CfgPersonal.VacacionesPagadas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Vacaciones.CfgPersonal.VacacionesAniversario]
Carpeta=Vacaciones
Clave=CfgPersonal.VacacionesAniversario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgPersonal.DiasAguinaldo]
Carpeta=Ficha
Clave=CfgPersonal.DiasAguinaldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Prestaciones
Prestaciones=DiasEspeciales
DiasEspeciales=Vacaciones
Vacaciones=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CfgPersonal.Configuracion
CfgPersonal.Configuracion=CfgPersonal.Sueldo
CfgPersonal.Sueldo=CfgPersonal.HorasExtras
CfgPersonal.HorasExtras=CfgPersonal.Faltas
CfgPersonal.Faltas=CfgPersonal.RetardosFalta
CfgPersonal.RetardosFalta=CfgPersonal.Incapacidades
CfgPersonal.Incapacidades=CfgPersonal.DiasAguinaldo
CfgPersonal.DiasAguinaldo=(Fin)

[Prestaciones.ListaEnCaptura]
(Inicio)=CfgPersonal.Configuracion
CfgPersonal.Configuracion=CfgPersonal.Vales
CfgPersonal.Vales=CfgPersonal.ValesBase
CfgPersonal.ValesBase=CfgPersonal.ValesPorcentaje
CfgPersonal.ValesPorcentaje=CfgPersonal.PremioAsistencia
CfgPersonal.PremioAsistencia=CfgPersonal.PremioAsistenciaBase
CfgPersonal.PremioAsistenciaBase=CfgPersonal.PremioAsistenciaPorcentaje
CfgPersonal.PremioAsistenciaPorcentaje=CfgPersonal.PremioPuntualidad
CfgPersonal.PremioPuntualidad=CfgPersonal.PremioPuntualidadBase
CfgPersonal.PremioPuntualidadBase=CfgPersonal.PremioPuntualidadPorcentaje
CfgPersonal.PremioPuntualidadPorcentaje=(Fin)

[DiasEspeciales.ListaEnCaptura]
(Inicio)=CfgPersonal.Configuracion
CfgPersonal.Configuracion=CfgPersonal.DomingosEnJornada
CfgPersonal.DomingosEnJornada=CfgPersonal.DomingosPrima
CfgPersonal.DomingosPrima=CfgPersonal.DomingosLaborados
CfgPersonal.DomingosLaborados=CfgPersonal.DomingosLaboradosFactor
CfgPersonal.DomingosLaboradosFactor=CfgPersonal.DescansosLaborados
CfgPersonal.DescansosLaborados=CfgPersonal.DescansosLaboradosFactor
CfgPersonal.DescansosLaboradosFactor=CfgPersonal.FestivosLaborados
CfgPersonal.FestivosLaborados=CfgPersonal.FestivosLaboradosFactor
CfgPersonal.FestivosLaboradosFactor=(Fin)

[Vacaciones.ListaEnCaptura]
(Inicio)=CfgPersonal.Configuracion
CfgPersonal.Configuracion=CfgPersonal.VacacionesPagoPrima
CfgPersonal.VacacionesPagoPrima=CfgPersonal.VacacionesPrima
CfgPersonal.VacacionesPrima=CfgPersonal.VacacionesDisfrutadas
CfgPersonal.VacacionesDisfrutadas=CfgPersonal.VacacionesPagadas
CfgPersonal.VacacionesPagadas=CfgPersonal.VacacionesAniversario
CfgPersonal.VacacionesAniversario=(Fin)
