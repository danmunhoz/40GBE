<h1>Jobs </h1>
<div class="row">
    <div class="col-md-12">
        @forelse ($jobs as $job)
            @if($job->status === 'waiting')
            <div class="row">
                <div class="col-md-9">
                    <i class="material-icons">access_time</i><span style="text-decoration: underline;">{{ $job->name }}</span>
                </div>
                <div class="col-md-3">
                    <a href="{{ url('kill', [$job->id]) }}" class="text-danger"><i class="material-icons">clear</i></a>
                </div>
            </div>
            @elseif($job->status === 'running')
            <div class="row">
                <div class="col-md-9">
                    <a href="{{ url('report', [$job->id]) }}"><i class="material-icons">cached</i><span style="text-decoration: underline;">{{ $job->name }}</span> </a>
                </div>
                <div class="col-md-3">
                    <a href="{{ url('kill', [$job->id]) }}" class="text-danger"><i class="material-icons">clear</i></a>
                </div>
            </div>
            @elseif($job->status === 'done')
            <div class="row">
                <div class="col-md-9">
                    <a class="text-success" href="{{ url('report', [$job->id]) }}"><i class="material-icons">done</i><span style="text-decoration: underline;">{{ $job->name }}</span> </a>
                </div>
                <div class="col-md-3">
                    <i class="material-icons">clear</i>
                </div>
            </div>
            @elseif($job->status === 'error')
            <div class="row">
                <div class="col-md-9">
                    <a class="text-warning"  href="{{ url('report', [$job->id]) }}><i class="material-icons">error_outline</i><span style="text-decoration: underline;">{{ $job->name }}</span></a>
                </div>
                <div class="col-md-3">
                    <a href="{{ url('kill', [$job->id]) }}" class="text-muted"><i class="material-icons">clear</i></a>
                </div>
            </div>
            @elseif($job->status === 'cancelled')
            <div class="row">
                <div class="col-md-9">
                    <a class="text-muted" href="{{ url('report', [$job->id]) }}"><i class="material-icons">do_not_disturb</i><span style="text-decoration: underline;">{{ $job->name }}</span></a>
                </div>
                <div class="col-md-3">
                    <i class="material-icons">clear</i>
                </div>
            </div>
            @endif
        @empty
            <li><strong>No Jobs</strong></li>
        @endforelse
    </div>
</div>